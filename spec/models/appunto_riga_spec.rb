require 'spec_helper'

describe AppuntoRiga do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: appunto_righe
#
#  id              :integer         not null, primary key
#  libro_id        :integer
#  appunto_id      :integer
#  quantita        :integer
#  prezzo          :decimal(8, 2)
#  consegnato      :boolean
#  pagato          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  prezzo_unitario :integer
#  currency        :string(255)
#  sconto          :decimal(8, 2)
#  fattura_id      :integer
#

