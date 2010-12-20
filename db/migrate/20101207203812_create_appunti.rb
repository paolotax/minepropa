class CreateAppunti < ActiveRecord::Migration
  def self.up
    create_table :appunti do |t|
      t.string :destinatario
      t.string :scuola
      t.text :note
      t.string :telefono
      t.string :stato
      t.date :scadenza

      t.timestamps
    end
  end

  def self.down
    drop_table :appunti
  end
end
