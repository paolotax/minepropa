class UpdateIndirizzi < ActiveRecord::Migration
  def self.up
    remove_column :indirizzi, :latitudine
    remove_column :indirizzi, :longitudine
    
    add_column :indirizzi, :latitude, :string
    add_column :indirizzi, :longitude, :string
    add_column :indirizzi, :gmaps, :boolean
  end

  def self.down
    remove_column :indirizzi, :latitude
    remove_column :indirizzi, :longitude
    remove_column :indirizzi, :gmaps
  end             
end
