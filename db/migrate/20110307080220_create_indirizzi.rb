class CreateIndirizzi < ActiveRecord::Migration
  def self.up
    create_table :indirizzi do |t|
      t.string :destinatario
      t.string :indirizzo
      t.string :cap
      t.string :citta
      t.string :provincia
      t.float  :latitudine
      t.float  :longitudine
      t.string :tipo
      t.integer :indirizzable_id
      t.string :indirizzable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :indirizzi
  end
end
