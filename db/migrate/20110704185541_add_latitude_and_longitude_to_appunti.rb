class AddLatitudeAndLongitudeToAppunti < ActiveRecord::Migration

  def self.up
    add_column :appunti, :latitude, :float
    add_column :appunti, :longitude, :float
    
    say "Run 'rake update_lat_long' after this migration completed"
  end

  def self.down
    remove_column :appunti, :latitude
    remove_column :appunti, :longitude
  end
end
