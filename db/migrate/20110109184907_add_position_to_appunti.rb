class AddPositionToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :position, :integer
  end

  def self.down
    remove_column :appunti, :position
  end
end
