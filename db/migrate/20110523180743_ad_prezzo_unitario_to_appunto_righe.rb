class AdPrezzoUnitarioToAppuntoRighe < ActiveRecord::Migration
  def self.up
    add_column :appunto_righe, :prezzo_unitario, :integer  # in cents
    add_column :appunto_righe, :currency, :string
    remove_column :appunto_righe, :sconto
    add_column :appunto_righe, :sconto, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :appunto_righe, :prezzo_unitario
    remove_column :appunto_righe, :currency
    remove_column :appunto_righe, :sconto
    add_column :appunto_righe, :sconto, :decimal, :precision => 8, :scale => 2
  end
end
