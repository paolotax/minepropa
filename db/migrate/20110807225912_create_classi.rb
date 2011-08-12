class CreateClassi < ActiveRecord::Migration
  def self.up
    create_table :classi do |t|
      
      t.integer  :classe
      t.string   :sezione
      t.integer  :nr_alunni
      t.integer  :scuola_id
      t.string   :spec_id
      t.string   :sper_id
      
      t.timestamps
    end
    
    add_index :classi, [:scuola_id, :classe, :sezione], :name => "index_classi_on_scuola_id_and_classe_and_sezione", :unique => true
    
  end

  def self.down
    drop_table :classi
  end
end
