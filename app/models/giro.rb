# == Schema Information
# Schema version: 20110909041834
#
# Table name: giri
#
#  id         :integer         not null, primary key
#  titolo     :string(255)
#  data       :date
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Giro < ActiveRecord::Base
  
  has_many :tappe, :dependent => :destroy
  accepts_nested_attributes_for :tappe, :reject_if => lambda { |a| a[:scuola_id].blank? }, :allow_destroy => true
    
  has_many :scuole, :through => :tappe
end
