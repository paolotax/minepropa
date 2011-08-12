class CreateAdozioni < ActiveRecord::Migration
  def self.up
    create_table :adozioni do |t|
      
      t.integer  :classe_id
      t.integer  :libro_id
      t.integer  :materia_id
      t.integer  :nr_copie
      t.integer  :nr_sezioni
      t.string   :anno

      t.timestamps
    end
  end

  def self.down
    drop_table :adozioni
  end
end
