class CreateVisite < ActiveRecord::Migration
  def self.up
    create_table :visite do |t|
      t.date :data
      t.time :ora_inizio
      t.time :ora_fine
      t.string :note
      t.integer :visitable_id
      t.string :visitable_type
      t.integer :user_id

      t.timestamps
    end
    
    add_index :visite, [:visitable_id,:visitable_type]
    add_index :visite, :user_id
  end

  def self.down
    drop_table :visite
  end
end
