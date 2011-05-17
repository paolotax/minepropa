# == Schema Information
# Schema version: 20110517131235
#
# Table name: libri
#
#  id           :integer         not null, primary key
#  titolo       :string(255)
#  copertina    :decimal(8, 2)
#  categoria_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Libro < ActiveRecord::Base
  has_many :appunto_righe
end
