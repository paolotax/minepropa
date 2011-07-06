# == Schema Information
# Schema version: 20110228203907
#
# Table name: appunti
#
#  id           :integer         not null, primary key
#  destinatario :string(255)
#  note         :text
#  telefono     :string(255)
#  stato        :string(255)     default(""), not null
#  scadenza     :date
#  created_at   :datetime
#  updated_at   :datetime
#  scuola_id    :integer
#  position     :integer
#  email        :string(255)
#  user_id      :integer
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
  has_many :appunto_righe,  :dependent => :destroy
  
  
  delegate :nome_scuola, :to => :scuola,
                         :allow_nil => true
  

  accepts_nested_attributes_for :indirizzi,     :reject_if => lambda { |a| a[:citta].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :appunto_righe, :reject_if => lambda { |a| (a[:quantita].blank? || a[:libro_id].blank?)}, :allow_destroy => true
  
  
  validates :user_id,  :presence => true
  validates :nome_scuola,  :presence => true
  
  before_save :cleanup, :set_lat_long
  
  scope :per_id,           :order => "appunti.id DESC" 
  scope :per_destinatario, :order => 'appunti.destinatario asc'
  scope :per_scuola_id,    :order => 'appunti.scuola_id asc'
    
  scope :in_sospeso,  where(:stato.eq => "P")
  scope :da_fare,     where({:stato.ne => 'X'} & {:stato.ne => 'P'})
  scope :in_corso,    where(:stato.ne => 'X')
  scope :completati,  where(:stato.eq => 'X')
  
  scope :da_correggere, where("scuola_id is null")
  scope :con_recapito,  where("telefono <> '' or email <> ''")

  scope :non_assegnato, where("not exists (select visite.visitable_id from visite 
                                            where visite.visitable_type = 'Appunto' 
                                            and visite.visitable_id = appunti.id)")
  scope :assegnato, joins(:visite)
  
  scope :modificato_dal, lambda{ |ago, riga_ago| includes(:appunto_righe).where("appunti.updated_at >= ? OR appunto_righe.updated_at >= ?", ago, riga_ago)} 
  
  scope :con_righe, where("exists (select appunto_righe.appunto_id from appunto_righe 
                           where appunto_righe.appunto_id = appunti.id)")
  
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
  
  def self.provincia(params)
    
    appunti = scoped
    if params[:provincia]
      appunti = appunti.joins(:scuola).where(:scuola => { :provincia => params[:provincia] })
    end
    
    appunti
  end

  def scuola_nome_scuola_completo
    [scuola.nome_scuola, '('+scuola.citta.capitalize+')'].join(" ") if scuola
  end

  # def nome_scuola
  #   scuola.nome_scuola if scuola
  # end  
  
  def nome_scuola=(nome)
    self.scuola = Scuola.find_by_nome_scuola(nome)
  end
  
  def note_formatted
    simple_format(self.note)
  end
  
  def note_formatted=(note)
    self.note = note
  end
  

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
  
end
