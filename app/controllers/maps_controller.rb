class MapsController < ApplicationController
  
  def update_latlong
    @indirizzo = Indirizzo.find(params[:id])
    if @indirizzo.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude] )
      head :ok
    else
      head :error
    end
  end
end
