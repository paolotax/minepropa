task :update_lat_long => :environment do
  Appunto.where("scuola_id is not null").each do |a|  
    a.update_attribute(:latitude,a.scuola.indirizzi.first[:latitude]) unless a.scuola.indirizzi.empty?
    a.update_attribute(:longitude, a.scuola.indirizzi.first[:longitude]) unless a.scuola.indirizzi.empty? 
  end
end
