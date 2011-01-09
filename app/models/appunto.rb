# == Schema Information
# Schema version: 20110109185008
#
# Table name: appunti
#
#  id           :integer(4)      not null, primary key
#  destinatario :string(255)
#  note         :text
#  telefono     :string(255)
#  stato        :string(255)
#  scadenza     :date
#  created_at   :datetime
#  updated_at   :datetime
#  scuola_id    :string(255)
#  position     :integer(4)
#

class Appunto < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  
  default_scope :order => "appunti.updated_at DESC"
  
  scope :in_sospeso, where("stato = ?", "P") 
  scope :in_corso, where("stato != ?", "X")

  def self.search(search)  
    if search  
      where('destinatario LIKE ?', "%#{search}%")  
    else  
      scoped  
    end  
  end  
  
end
