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