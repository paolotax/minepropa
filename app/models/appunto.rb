# == Schema Information
# Schema version: 20110705104946
#
# Table name: appunti
#
#  id             :integer         not null, primary key
#  destinatario   :string(255)
#  note           :text
#  telefono       :string(255)
#  stato          :string(255)     default(""), not null
#  scadenza       :date
#  created_at     :datetime
#  updated_at     :datetime
#  scuola_id      :integer
#  position       :integer
#  email          :string(255)
#  user_id        :integer
#  totale_copie   :integer         default(0)
#  totale_importo :float           default(0.0)
#  latitude       :float
#  longitude      :float
#

class Appunto < ActiveRecord::Base
  
  reverse_geocoded_by :latitude, :longitude
  
  acts_as_list
  
  acts_as_taggable
  acts_as_taggable_on :locations, :status
  
  has_paper_trail
  
  belongs_to :scuola
  belongs_to :user
  
  has_many :visite,    :as => :visitable,     :dependent => :destroy
  has_many :indirizzi, :as => :indirizzable,  :dependent => :destroy
  has_many :appunto_righe,  :include => [:libro], :dependent => :destroy
  
  has_one :fattura, :through => :appunto_righe
  
  delegate :nome_scuola, :citta, :provincia, :position, :to => :scuola,
                         :prefix => true,
                         :allow_nil => true
  

  accepts_nested_attributes_for :indirizzi,     :reject_if => lambda { |a| a[:citta].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :appunto_righe, :reject_if => lambda { |a| (a[:quantita].blank? || a[:libro_id].blank?)}, :allow_destroy => true
  
  
  validates :user_id,  :presence => true
  validates :scuola_nome_scuola,  :presence => true
  
  before_save :cleanup, :set_lat_long
  
  scope :per_id,           :order => "appunti.id DESC" 
  scope :per_destinatario, :order => 'appunti.destinatario asc'
  scope :per_scuola_id,    :order => 'appunti.scuola_id asc'
    
  scope :in_sospeso,  where(:stato.eq => "P")
  scope :da_fare,     where({:stato.ne => 'X'} & {:stato.ne => 'P'})
  scope :in_corso,    where(:stato.ne => 'X')
  scope :completati,  where(:stato.eq => 'X')
  
  scope :recent, where("appunti.created_at > ? or appunti.updated_at > ?", 2.weeks.ago, 2.weeks.ago)
  
  scope :da_correggere, where("scuola_id is null")
  scope :con_recapito,  where("appunti.telefono <> '' or appunti.email <> ''")

  scope :non_assegnato, where("not exists (select visite.visitable_id from visite 
                                            where visite.visitable_type = 'Appunto' 
                                            and visite.visitable_id = appunti.id)")
  scope :assegnato, joins(:visite)
  
  scope :modificato_dal, lambda{ |ago, riga_ago| includes(:appunto_righe).where("appunti.updated_at >= ? OR appunto_righe.updated_at >= ?", ago, riga_ago)} 
  
  scope :con_righe, where("exists (select appunto_righe.appunto_id from appunto_righe 
                           where appunto_righe.appunto_id = appunti.id)")

  
  scope :fatturato, where("exists (select appunto_righe.appunto_id from appunto_righe 
                                   where appunto_righe.appunto_id = appunti.id and appunto_righe.fattura_id is not null)" )
  
  scope :non_fatturato, where("exists (select appunto_righe.appunto_id from appunto_righe 
                                  where appunto_righe.appunto_id = appunti.id and appunto_righe.fattura_id is null)" )
  #vecchio stile
  #scope :instance_appunti, lambda { |user| where("appunti.user_id = ?", user.id) }
  
  # def self.search(params)  
  #   
  #   appunti = scoped
  #   if params[:search] 
  #     appunti = appunti.joins(:scuola)
  #     appunti = appunti.where('appunti.destinatario LIKE ? OR scuole.nome_scuola LIKE ?', "%" + params[:search] + "%", "%" + params[:search] + "%")
  #   end
  # 
  #   appunti
  # end 
  
  
  attr_reader :tag_tokens
  attr_reader :tag_add
  
  def tag_tokens=(ids)
    
    ids.gsub!(/CREATE_(.+?)_END/) do
      Tag.create!(:name => $1).id
    end
    
    tag_array = []
    ids.split(",").each do |t|
      tag_name =  Tag.find(t)
      tag_array <<  tag_name.name
    end
    self.tag_list = tag_array.join(',')
  end
  
  def tag_add=(ids)
    
    ids.gsub!(/CREATE_(.+?)_END/) do
      Tag.create!(:name => $1).id
    end
    
    tag_array = []
    ids.split(",").each do |t|
      tag_name =  Tag.find(t)
      tag_array <<  tag_name.name
    end
    self.tag_list = self.tag_list.to_s + ', ' + tag_array.join(',')
  end
  
  def tag_remove=(empty)
    #raise empty.inspect
    
    if empty == '1'
      self.tag_list = ''
    end
  end
  
  def self.filtra(params)

    appunti = scoped
    if params[:provincia]
      appunti = appunti.joins(:scuola).where(:scuola => { :provincia => params[:provincia] })
    end
    if params[:citta]
      appunti = appunti.joins(:scuola).where(:scuola => { :citta => params[:citta] })
    end
    appunti
  end


  


  def scuola_nome_scuola_completo
    [scuola.nome_scuola, '('+scuola.citta.capitalize+')'].join(" ") if scuola
  end

  
  # non funziona (user_id)
  def scuola_nome_scuola=(nome)
    # self.scuola = Scuola.find_by_nome_scuola(nome)
  end
  
  def note_formatted
    simple_format(self.note)
  end
  
  def note_formatted=(note)
    self.note = note
  end
  
  def after_save
    self.update_counter_cache
  end

  def after_destroy
    self.update_counter_cache
  end

  def update_counter_cache
    self.scuola.appunti_in_corso_counter = Appunto.in_corso.where("scuola_id = ?", self.scuola.id).count
    self.scuola.save
  end
  
  
  
  def self.controlla_appunti
    
    errori = []
    
    Appunto.con_righe.each do |a|
      
      calc = a.appunto_righe.sum('quantita * prezzo_unitario').to_f / 100 
      
      diff = calc - a.totale_importo
      if !(diff == 0.0) 
        errori << "#{a.id} #{diff} #{a.scuola.nome_scuola}"
      end
      
    end
    
    errori
  end
  
  
  
  
  after_save :update_righe_status
  
  private
  
    def cleanup
      self[:destinatario] = self[:destinatario].titleize unless self[:destinatario].nil?
    end
    
    def set_lat_long
      indirizzo = scuola.indirizzi.first
      unless indirizzo.nil?
        self.latitude = indirizzo.latitude
        self.longitude = indirizzo.longitude
      end
    end
    
    def update_righe_status
      
      if stato == 'X'
        appunto_righe.each do |riga|
          riga.update_attributes({:pagato => true, :consegnato => true})
        end
      elsif stato == 'P'
        appunto_righe.each do |riga|
          riga.update_attributes({:pagato => false, :consegnato => true})
        end
      else
        appunto_righe.each do |riga|
          riga.update_attributes({:pagato => false, :consegnato => false})
        end
      end
    end
    
  
end
