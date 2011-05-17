class CreateAppuntoRighe < ActiveRecord::Migration
  def self.up
    create_table :appunto_righe do |t|
      t.integer :libro_id
      t.integer :appunto_id
      t.integer :quantita
      t.decimal :prezzo, :precision => 8, :scale => 2
      t.decimal :sconto, :precision => 3, :scale => 2
      t.boolean :consegnato
      t.boolean :pagato

      t.timestamps
    end
  end

  def self.down
    drop_table :appunto_righe
  end
end
