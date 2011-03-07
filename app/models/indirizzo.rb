# == Schema Information
# Schema version: 20110307080220
#
# Table name: indirizzi
#
#  id                :integer         not null, primary key
#  destinatario      :string(255)
#  indirizzo         :string(255)
#  cap               :string(255)
#  citta             :string(255)
#  provincia         :string(255)
#  latitudine        :float
#  longitudine       :float
#  tipo              :string(255)
#  indirizzable_id   :integer
#  indirizzable_type :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Indirizzo < ActiveRecord::Base
  
  belongs_to :indirizzable, :polymorphic => true
  
end
