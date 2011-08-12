class Adozione < ActiveRecord::Base
  belongs_to :classe
  belongs_to :libro
  belongs_to :scuola
  belongs_to :materia

  validates :classe_id, :uniqueness => {:scope => [:materia_id, :libro_id],
                                        :message => "e' gia' stata utilizzata"}   
end