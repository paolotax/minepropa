# == Schema Information
# Schema version: 20101227221959
#
# Table name: scuole
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  citta      :string(255)
#  provincia  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Scuola < ActiveRecord::Base
  
  has_many :appunti
  
end
