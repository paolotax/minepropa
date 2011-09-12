# == Schema Information
# Schema version: 20110808105615
#
# Table name: classi
#
#  id         :integer         not null, primary key
#  classe     :integer
#  sezione    :string(255)
#  nr_alunni  :integer
#  scuola_id  :integer
#  spec_id    :string(255)
#  sper_id    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Classe < ActiveRecord::Base
  belongs_to :scuola
  has_many :adozioni,     :dependent => :destroy
  
  validates :sezione, :uniqueness => {:scope => [:classe, :scuola_id],
                                        :message => "e' gia' stata utilizzata"}
  
  after_save :update_nr_copie


  scope :per_scuola, lambda { 
    |sc| where('classi.scuola_id = ?', sc).order([:classe, :sezione])
  }
  
  def to_s
    "#{self.classe} #{self.sezione}"
  end
  
  def update_nr_copie
    self.adozioni.scolastico.each do |a|
      a.update_attributes(:nr_copie => self.nr_alunni)
    end
  end
    
  
end
