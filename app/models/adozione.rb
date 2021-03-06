# == Schema Information
# Schema version: 20110808105615
#
# Table name: adozioni
#
#  id         :integer         not null, primary key
#  classe_id  :integer
#  libro_id   :integer
#  materia_id :integer
#  nr_copie   :integer
#  nr_sezioni :integer
#  anno       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Adozione < ActiveRecord::Base
  belongs_to :classe
  belongs_to :libro
  belongs_to :scuola
  belongs_to :materia

  validates :classe_id, :uniqueness => {:scope => [:materia_id, :libro_id],
                                        :message => "e' gia' stata utilizzata"}  
                                        
                                        
  scope :scolastico, joins(:libro).where("libri.type = 'Scolastico'")
  # scope :per_scuola, lambda {|s| }
  
  scope :per_classe_e_sezione, joins(:classe).order("classi.classe, classi.sezione, adozioni.materia_id")
  
  def after_save
    self.update_counter_cache
  end

  def after_destroy
    self.update_counter_cache
  end

  def update_counter_cache
    self.classe.scuola.mie_adozioni_counter = Adozione.joins(:classe).scolastico.where("classi.scuola_id = ?", self.classe.scuola.id).count
    self.classe.scuola.save
  end 
end
