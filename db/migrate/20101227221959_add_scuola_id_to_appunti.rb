class AddScuolaIdToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :scuola_id, :string
    remove_column :appunti, :scuola
  end

  def self.down
    remove_column :appunti, :scuola_id
    add_column :appunti, :scuola, :string
  end
end
