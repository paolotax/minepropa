class CreateScuole < ActiveRecord::Migration
  def self.up
    create_table :scuole do |t|
      t.string :nome
      t.string :citta
      t.string :provincia
      t.timestamps
    end
  end

  def self.down
    drop_table :scuole
  end
end
