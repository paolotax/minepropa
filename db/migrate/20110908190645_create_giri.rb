class CreateGiri < ActiveRecord::Migration
  def self.up
    create_table :giri do |t|

      t.string :titolo
      t.date :data
      t.text :note
      t.timestamps
    end
    

  end

  def self.down
    drop_table :giri
  end
end
