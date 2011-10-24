class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :codice_fiscale, :string
    add_column :users, :partita_iva, :string
  end

  def self.down
    remove_column :users, :partita_iva
    remove_column :users, :codice_fiscale
  end
end
