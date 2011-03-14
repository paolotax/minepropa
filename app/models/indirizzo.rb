# == Schema Information
# Schema version: 20110308194101
#
# Table name: indirizzi
#
#  id                :integer         not null, primary key
#  destinatario      :string(255)
#  indirizzo         :string(255)
#  cap               :string(255)
#  citta             :string(255)
#  provincia         :string(255)
#  tipo              :string(255)
#  indirizzable_id   :integer
#  indirizzable_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  latitude          :string(255)
#  longitude         :string(255)
#  gmaps             :boolean
#

class Indirizzo < ActiveRecord::Base
  
  acts_as_gmappable :process_geocoding => "before_save"
  
  belongs_to :indirizzable, :polymorphic => true
  
  def label_indirizzo
    self.destinatario + '</br>' +
    self.indirizzo + '</br>' +
    self.cap + ' ' + self.citta + ' ' + self.provincia
  end
  
  def gmaps4rails_address
    [self.indirizzo, self.citta, self.provincia].join(', ')
  end
  
  def self.gmaps4rails_trusted_scopes
    ["find", 'max_qi', 'first']
  end
  
  def gmaps4rails_infowindow
    name = self.citta.nil? ? "default" : self.citta
    "<em>" + self.citta + "</em>"
  end
  
  def to_gomap_marker
    data = []
    data << { :latitude => self.latitude.to_f, :longitude => self.longitude.to_f, :title => self.citta, :draggable => true, :id => 'baseMarker', :html => { :content => self.label_indirizzo, :popup => true  } }    
  end
end
