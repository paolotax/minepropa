# == Schema Information
# Schema version: 20110113205851
#
# Table name: scuole
#
#  id          :integer(4)      not null, primary key
#  nome_scuola :string(255)
#  citta       :string(255)
#  provincia   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  position    :integer(4)
#  user_id     :integer(4)
#

class Scuola < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  has_many :appunti
  has_many :visite, :as => :visitable,  :dependent => :destroy 
  
  attr_accessible :nome_scuola, :citta, :provincia, :position
  
  validates :user_id,      :presence => true
  validates :nome_scuola,  :presence => true
  validates :citta,        :presence => true
  validates :provincia,    :presence => true, :length => { :maximum => 2 }
  
  before_save :clean_up
  
  # default_scope :order => "scuole.position ASC"
  
  def nome_scuola_completo
     [nome_scuola, citta].join(" ")
  end  
  
  def self.search_for_nome(q)
    [:nome_scuola].inject(scoped) do |combined_scope, attr|        #tolto :citta dall array per AND
       combined_scope.where("scuole.#{attr} LIKE ?", "%#{q}%")
    end
  end
  
  def self.con_appunti_in_corso(user_id)
    # Scuola
    #   .where(:user_id.eq => user_id)
    #   .joins(:appunti)
    #   .where(:appunti => {:stato.ne => 'X'})
    #   .select("scuole.id, scuole.nome_scuola, scuole.citta, scuole.provincia, scuole.position")
    #   .select("count(appunti.id) as nr_appunti")
    #   .group("appunti.scuola_id")
    #   .order("scuole.provincia, scuole.position")
  end
  
  private
  
    def clean_up
      self[:nome_scuola] = self[:nome_scuola].upcase
      self[:provincia]   = self[:provincia].upcase
      self[:citta] = self[:citta].titleize
      
      # x = self[:citta].split.each {|v| v.capitalize! } 
      # self[:citta] = x.join(" ")
    end
  
end
