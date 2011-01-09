class AddPositionToScuole < ActiveRecord::Migration
  def self.up
    add_column :scuole, :position, :integer
  end

  def self.down
    remove_column :scuole, :position
  end
end
