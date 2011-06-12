class AddCopieToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :totale_copie, :integer, :default => 0
    add_column :appunti, :totale_importo, :float, :default => 0.00
  end

  def self.down
    remove_column :appunti, :totale_copie
    remove_column :appunti, :totale_importo
    
  end
end
