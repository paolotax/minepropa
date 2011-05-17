class CreateLibri < ActiveRecord::Migration
  def self.up
    create_table :libri do |t|
      t.string :titolo
      t.decimal :copertina, :precision => 8, :scale => 2
      t.integer :categoria_id

      t.timestamps
    end
  end

  def self.down
    drop_table :libri
  end
end
