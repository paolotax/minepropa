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
  has_many :adozioni
  
  validates :sezione, :uniqueness => {:scope => [:classe, :scuola_id],
                                        :message => "e' gia' stata utilizzata"}
  
  scope :per_scuola, lambda { 
    |sc| where('classi.scuola_id = ?', sc).order([:classe, :sezione])
  }
  
  def to_s
    "#{self.classe} #{self.sezione}"
  end
  
  
end
