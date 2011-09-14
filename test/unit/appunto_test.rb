require 'test_helper'

class AppuntoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: appunti
#
#  id             :integer         not null, primary key
#  destinatario   :string(255)
#  note           :text
#  telefono       :string(255)
#  stato          :string(255)     default(""), not null
#  scadenza       :date
#  created_at     :datetime
#  updated_at     :datetime
#  scuola_id      :integer
#  position       :integer
#  email          :string(255)
#  user_id        :integer
#  totale_copie   :integer         default(0)
#  totale_importo :float           default(0.0)
#  latitude       :float
#  longitude      :float
#

