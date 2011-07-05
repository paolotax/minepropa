class ChangeIndirizziLatitudeAndLongitude < ActiveRecord::Migration
  class Indirizzo < ActiveRecord::Base
  end
  
  def self.up
    rename_column :indirizzi, :latitude, :lat
    rename_column :indirizzi, :longitude, :long
    add_column :indirizzi, :latitude, :float
    add_column :indirizzi, :longitude, :float

    say "Reset lat-long"
    Indirizzo.reset_column_information

    Indirizzo.all.each do |a|
      a.update_attribute :latitude,  a.lat.to_f
      a.update_attribute :longitude, a.long.to_f
    end
    
    remove_column :indirizzi, :lat
    remove_column :indirizzi, :long
  end



  def self.down
    
    rename_column :indirizzi, :latitude, :lat
    rename_column :indirizzi, :longitude, :long
    add_column :indirizzi, :latitude, :string
    add_column :indirizzi, :longitude, :string

    say "Reset lat-long"
    Indirizzo.reset_column_information

    Indirizzo.all.each do |a|
      a.update_attribute :latitude,  a.lat.to_s
      a.update_attribute :longitude, a.long.to_s
    end
    
    remove_column :indirizzi, :lat
    remove_column :indirizzi, :long
    
  end
end
