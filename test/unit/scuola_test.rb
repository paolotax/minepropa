require 'test_helper'

class ScuolaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: scuole
#
#  id                       :integer         not null, primary key
#  nome_scuola              :string(255)
#  citta                    :string(255)
#  provincia                :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  position                 :integer
#  user_id                  :integer
#  ancestry                 :string(255)
#  telefono                 :string(255)
#  fax                      :string(255)
#  cellulare                :string(255)
#  email                    :string(255)
#  partita_iva              :string(255)
#  codice_fiscale           :string(255)
#  mie_adozioni_counter     :integer         default(0)
#  appunti_in_corso_counter :integer         default(0)
#

