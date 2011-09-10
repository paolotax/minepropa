class CreateTappe < ActiveRecord::Migration
  def self.up
    create_table :tappe do |t|

      t.integer :giro_id
      t.integer :scuola_id
      t.integer :posizione
      t.timestamps
    end
  end

  def self.down
    drop_table :tappe
  end
end
