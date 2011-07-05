# == Schema Information
# Schema version: 20110418171757
#
# Table name: scuole
#
#  id          :integer         not null, primary key
#  nome_scuola :string(255)
#  citta       :string(255)
#  provincia   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer
#  user_id     :integer
#  ancestry    :string(255)
#

class Scuola < ActiveRecord::Base
  
  acts_as_list
  has_ancestry
  
  belongs_to :user
  has_many :appunti
  
  has_many :visite,    :as => :visitable,    :dependent => :destroy 
  has_many :indirizzi, :as => :indirizzable, :dependent => :destroy
  
  #attr_accessible :nome_scuola, :citta, :provincia, :position
  
  accepts_nested_attributes_for :indirizzi, :allow_destroy => true 
  
  validates :user_id,      :presence => true
  validates :nome_scuola,  :presence => true
  validates :citta,        :presence => true
  validates :provincia,    :presence => true, :length => { :maximum => 2 }
  
  before_save :clean_up
  
  scope :direzioni,  where(:nome_scuola.matches % "IC %" | :nome_scuola.matches % "D %")
  
  # default_scope :order => "scuole.position ASC"
  
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
