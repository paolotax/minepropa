class AddFieldsToFatture < ActiveRecord::Migration
  def self.up
    add_column :fatture, :condizioni_pagamento, :string
    add_column :fatture, :pagata, :boolean
    add_column :fatture, :totale_copie,    :integer, :default => 0
    add_column :fatture, :importo_fattura, :integer, :default => 0
    add_column :fatture, :totale_iva,      :integer, :default => 0 
    add_column :fatture, :currency, :string
  end

  def self.down
    remove_column :fatture, :condizioni_pagamento
    remove_column :fatture, :pagata
    remove_column :fatture, :totale_copie
    remove_column :fatture, :importo_fattura
    remove_column :fatture, :totale_iva
    remove_column :fatture, :currency
  end
end
