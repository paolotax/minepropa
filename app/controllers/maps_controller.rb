class MapsController < ApplicationController
  
  respond_to :json

  def update_latlong
    @indirizzo = Indirizzo.find(params[:id])
    if @indirizzo.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude] )
      head :ok
    else
      head :error
    end
  end
  
  def get_appunti_markers

    @data = []
    @appunti = Appunto.in_corso.assegnato
  
    @appunti.each do |appunto|
      indirizzo = Indirizzo.where("indirizzable_id = ?", appunto.scuola_id ).first
      
      @data << { 
                :latitude => indirizzo.latitude.to_f, 
                :longitude => indirizzo.longitude.to_f, 
                :title => indirizzo.citta, 
                :draggable => false, 
                :id => 'm_' +  indirizzo.id.to_s, 
                :html => { :content => indirizzo.label_indirizzo  } 
               }
    end
    
    respond_with(@data)
  end
  
  def get_appunto_marker

    @data = []
    appunto = Appunto.find(params[:id])
    indirizzo = Indirizzo.where("indirizzable_id = ?", appunto.scuola_id ).first
      
    @data << { 
              :latitude => indirizzo.latitude.to_f, 
              :longitude => indirizzo.longitude.to_f, 
              :title => indirizzo.citta, 
              :draggable => false, 
              :id => 'm_' +  indirizzo.id.to_s, 
              :html => { :content => indirizzo.label_indirizzo } 
             }
    
    respond_with(@data)
  end
end
