# == Schema Information
# Schema version: 20110517131235
#
# Table name: appunto_righe
#
#  id         :integer         not null, primary key
#  libro_id   :integer
#  appunto_id :integer
#  quantita   :integer
#  prezzo     :decimal(8, 2)
#  sconto     :decimal(3, 2)
#  consegnato :boolean
#  pagato     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class AppuntoRiga < ActiveRecord::Base
  belongs_to :libro
  belongs_to :appunto
end
