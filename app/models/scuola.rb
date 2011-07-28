# == Schema Information
# Schema version: 20110705104946
#
# Table name: scuole
#
#  id             :integer         not null, primary key
#  nome_scuola    :string(255)
#  citta          :string(255)
#  provincia      :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  position       :integer
#  user_id        :integer
#  ancestry       :string(255)
#  telefono       :string(255)
#  fax            :string(255)
#  cellulare      :string(255)
#  email          :string(255)
#  partita_iva    :string(255)
#  codice_fiscale :string(255)
#

class Scuola < ActiveRecord::Base
  
  acts_as_list
  has_ancestry
  
  belongs_to :user
  has_many :appunti
  has_many :fatture
  
  has_many :visite,    :as => :visitable,    :dependent => :destroy 
  has_many :indirizzi, :as => :indirizzable, :dependent => :destroy
  
  #attr_accessible :nome_scuola, :citta, :provincia, :position
  
  accepts_nested_attributes_for :indirizzi, :allow_destroy => true 
  
  validates :user_id,      :presence => true
  validates :nome_scuola,  :presence => true,
                           :uniqueness => { :scope => :user_id, :message => "gia' utilizzato!"}
  validates :citta,        :presence => true
  validates :provincia,    :presence => true, :length => { :is => 2 }
  
  before_save :clean_up
  
  scope :direzioni,  where(:nome_scuola.matches % "IC %" | :nome_scuola.matches % "D %")
  scope :elementari, where(:nome_scuola.matches % "E %")
  scope :cartolerie, where(:nome_scuola.matches % "C %")
  scope :dell_utente,   lambda { |user| where('scuole.user_id = ?', user) }
  scope :per_provincia, lambda { |prov| where('scuole.provincia = ?', prov) }
  
  scope :con_appunti_in_corso, lambda {
                                  select('scuole.id, scuole.nome_scuola, count(appunti.id) as count_appunti_id').joins(:appunti).group('scuole.id, scuole.nome_scuola') & Appunto.in_corso
                               }
  
  # default_scope :order => "scuole.position ASC"
  
  def to_s
    "#{nome_scuola} #{citta} #{provincia}"
  end
  
  def nome_scuola_completo
     [nome_scuola, citta].join(" ")
  end  

  def self.search_for_nome(q)
    [:nome_scuola].inject(scoped) do |combined_scope, attr|        #tolto :citta dall array per AND
       combined_scope.where("scuole.#{attr} LIKE ?", "%#{q}%")
    end
  end

  def lat_long
    indirizzo = self.indirizzi.first
    return indirizzo.latitude.to_s+','+indirizzo.longitude.to_s unless indirizzo.nil?
  end
  
  private
  
    def clean_up
      self[:nome_scuola] = self[:nome_scuola].upcase
      self[:provincia]   = self[:provincia].upcase
      self[:citta]       = self[:citta].titleize
    end
  
end
