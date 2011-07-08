class CreateFatture < ActiveRecord::Migration
  def self.up
    create_table :fatture do |t|
      t.integer :numero
      t.date :data
      t.integer :scuola_id
      t.integer :user_id
      t.integer :causale_id
      t.boolean :dettaglio_righe

      t.timestamps
    end
  
    add_column :appunto_righe, :fattura_id, :integer
    add_index  :appunto_righe, :fattura_id
  
    add_index :fatture, :scuola_id
    add_index :fatture, :user_id
    add_index :fatture, :causale_id
    add_index :fatture, [:user_id, :causale_id, :numero], { :name => 'index_fatture_per_utente_and_causale', :unique => true}
  end
  

  def self.down
    drop_table :fatture
    
    remove_column :appunto_righe, :fattura_id
    remove_index  :appunto_righe, :fattura_id

    remove_index :fatture, :scuola_id
    remove_index :fatture, :user_id
    remove_index :fatture, :causale_id
    remove_index :fatture, 'per_utente_and_causale'
  end
  
    
end
