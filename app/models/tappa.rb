# == Schema Information
# Schema version: 20110909041834
#
# Table name: tappe
#
#  id         :integer         not null, primary key
#  giro_id    :integer
#  scuola_id  :integer
#  posizione  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tappa < ActiveRecord::Base
  belongs_to :scuola
  belongs_to :giro
end
