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
  
  attr_accessible :nome_scuola, :citta, :provincia, :position
  
  validates :user_id,  :presence => true
  validates :nome_scuola,  :presence => true
  validates :citta,  :presence => true
  validates :provincia,  :presence => true, :length => { :maximum => 2 }
  
  # default_scope :order => "scuole.position ASC"
  
  def nome_scuola_completo
     [nome_scuola, citta].join(" ")
  end  
  
  def self.search_for_nome(q)
    [:nome_scuola].inject(scoped) do |combined_scope, attr|        #tolto :citta dall array per AND
       combined_scope.where("scuole.#{attr} LIKE ?", "%#{q}%")
    end
  end

  
  
end
