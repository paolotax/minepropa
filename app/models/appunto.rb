class Appunto < ActiveRecord::Base
  
  scope :in_sospeso, where("stato = ?", "P") 
  scope :in_corso, where("stato != ?", "X")

  def self.search(search)  
    if search  
      where('scuola LIKE ? OR destinatario LIKE ?', "%#{search}%", "%#{search}%")  
    else  
      scoped  
    end  
  end  
  
end
