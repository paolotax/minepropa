require 'spec_helper'

describe Fattura do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: fatture
#
#  id                   :integer         not null, primary key
#  numero               :integer
#  data                 :date
#  scuola_id            :integer
#  user_id              :integer
#  causale_id           :integer
#  dettaglio_righe      :boolean
#  created_at           :datetime
#  updated_at           :datetime
#  condizioni_pagamento :string(255)
#  pagata               :boolean
#  totale_copie         :integer         default(0)
#  importo_fattura      :integer         default(0)
#  totale_iva           :integer         default(0)
#  currency             :string(255)
#

