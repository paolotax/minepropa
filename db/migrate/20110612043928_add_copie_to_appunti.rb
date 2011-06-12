class AddCopieToAppunti < ActiveRecord::Migration
  class Appunto < ActiveRecord::Base
    has_many :appunto_righe
  end
  class AppuntoRiga < ActiveRecord::Base
    belongs_to :appunto
  end
  
  def self.up
    add_column :appunti, :totale_copie, :integer, :default => 0
    add_column :appunti, :totale_importo, :float, :default => 0.00
    
    say "Reset totali"
    Appunto.reset_column_information

    Appunto.all.each do |a|
      a.update_attribute :totale_copie, a.appunto_righe.map(&:quantita).sum
      a.update_attribute :totale_importo, a.appunto_righe.sum("quantita * prezzo_unitario").to_f / 100
    end
    
  end
  
  
  
  def self.down
    remove_column :appunti, :totale_copie
    remove_column :appunti, :totale_importo
    
  end
end
