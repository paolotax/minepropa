class Materia < ActiveRecord::Base
  has_many :adozioni
  #???
  has_many :libri, :through => :adozioni
end
