# == Schema Information
# Schema version: 20110808105615
#
# Table name: materie
#
#  id         :integer         not null, primary key
#  materia    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Materia < ActiveRecord::Base
  has_many :adozioni
  #???
  has_many :libri, :through => :adozioni
end
