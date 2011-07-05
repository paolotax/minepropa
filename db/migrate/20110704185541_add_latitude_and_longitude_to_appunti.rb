class AddLatitudeAndLongitudeToAppunti < ActiveRecord::Migration
  class Appunto < ActiveRecord::Base
    belongs_to :scuola
  end
  class Indirizzo < ActiveRecord::Base
    belongs_to :indirizzable, :polymorphic => true
  end
  class Scuola < ActiveRecord::Base
    has_many :appunti
    has_many :indirizzi, :as => :indirizzable, :dependent => :destroy
  end

  
  def self.up
    add_column :appunti, :latitude, :float
    add_column :appunti, :longitude, :float
    
    say "Reset lat-long"
    Appunto.reset_column_information

    Appunto.all.each do |a|
      scuola = a.scuola
      
      
      indirizzo = scuola.indirizzi.first unless scuola.nil?
      unless indirizzo.nil?
        a.update_attribute :latitude,  indirizzo.latitude
        a.update_attribute :longitude, indirizzo.longitude
      end
    end
    
    #Appunto.where("scuola_id is not null").each do |a|  a.update_attribute(:latitude,a.scuola.indirizzi.first[:latitude]) unless a.scuola.indirizzi.empty?;  a.update_attribute(:longitude, a.scuola.indirizzi.first[:longitude]) unless a.scuola.indirizzi.empty? end
    
    
  end

  def self.down
    remove_column :appunti, :latitude
    remove_column :appunti, :longitude
  end
end
