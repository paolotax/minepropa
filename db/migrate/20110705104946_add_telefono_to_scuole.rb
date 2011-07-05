class AddTelefonoToScuole < ActiveRecord::Migration
  def self.up
    add_column :scuole, :telefono, :string
    add_column :scuole, :fax, :string
    add_column :scuole, :cellulare, :string
    add_column :scuole, :email, :string
    add_column :scuole, :partita_iva, :string
    add_column :scuole, :codice_fiscale, :string
  end

  def self.down
    remove_column :scuole, :telefono
    remove_column :scuole, :fax
    remove_column :scuole, :cellulare
    remove_column :scuole, :email
    remove_column :scuole, :partita_iva
    remove_column :scuole, :codice_fiscale
  end
end
