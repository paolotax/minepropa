class CreateMaterie < ActiveRecord::Migration
  def self.up
    create_table :materie do |t|
      t.string :materia

      t.timestamps
    end
  end

  def self.down
    drop_table :materie
  end
end
