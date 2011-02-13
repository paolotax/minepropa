# == Schema Information
# Schema version: 20110203070131
#
# Table name: appunti
#
#  id           :integer(4)      not null, primary key
#  destinatario :string(255)
#  note         :text
#  telefono     :string(255)
#  stato        :string(255)     default(""), not null
#  scadenza     :date
#  created_at   :datetime
#  updated_at   :datetime
#  scuola_id    :integer(4)
#  position     :integer(4)
#  email        :string(255)
#  user_id      :integer(4)
#

class Appunto < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  belongs_to :user
  has_many :visite, :as => :visitable, :dependent => :destroy 
  
  validates :user_id,  :presence => true
  validates :nome_scuola,  :presence => true
  
  before_save :cleanup
  
  scope :per_id, :order => "appunti.id DESC" 
  scope :per_destinatario, :order => 'appunti.destinatario asc'
    
  scope :in_sospeso,  where(:stato.eq => "P").per_id
  scope :in_corso,    where(:stato.ne => 'X').per_id
  
  scope :da_correggere, where("scuola_id is null")
  scope :con_recapito,  where("telefono <> '' or email <> ''")

  scope :non_assegnato, where("not exists (select visite.visitable_id from visite 
                                            where visite.visitable_type = 'Appunto' 
                                            and visite.visitable_id = appunti.id)")
  scope :assegnato, joins(:visite)
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
  
  def self.provincia(params)
    
    appunti = scoped
    if params[:provincia]
      appunti = appunti.joins(:scuola).where(:scuola => { :provincia => params[:provincia]})
    end
    
    appunti
  end


  def scuola_nome_scuola_completo
    [scuola.nome_scuola, '('+scuola.citta.capitalize+')'].join(" ") if scuola
  end

  def nome_scuola
    scuola.nome_scuola if scuola
  end  
  
  def nome_scuola=(nome)
    self.scuola = Scuola.find_by_nome_scuola(nome)
  end
  
  def cleanup
    self[:destinatario] = self[:destinatario].titleize unless self[:destinatario].nil?
  end
  
end
