require 'spec_helper'

describe Indirizzo do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: indirizzi
#
#  id                :integer         not null, primary key
#  destinatario      :string(255)
#  indirizzo         :string(255)
#  cap               :string(255)
#  citta             :string(255)
#  provincia         :string(255)
#  tipo              :string(255)
#  indirizzable_id   :integer
#  indirizzable_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  gmaps             :boolean
#  latitude          :float
#  longitude         :float
#

