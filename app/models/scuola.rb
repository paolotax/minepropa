# == Schema Information
# Schema version: 20110109185008
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
#

class Scuola < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  has_many :appunti
  
  default_scope :order => "scuole.position ASC"
end
