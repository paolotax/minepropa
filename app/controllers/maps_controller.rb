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
    @appunti = Appunto.assegnato
  
    @appunti.each do |appunto|
      indirizzo = Indirizzo.where("indirizzable_id = ?", appunto.scuola_id ).first
      
      @data << { :latitude => indirizzo.latitude.to_f, :longitude => indirizzo.longitude.to_f, :title => indirizzo.citta, :draggable => false, :id => 'm_' +  indirizzo.id.to_s}
    end
    
    respond_with(@data)
  end
end
