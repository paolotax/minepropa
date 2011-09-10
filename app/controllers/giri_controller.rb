class GiriController < ApplicationController
    
  def index
    @giri = Giro.all
  end
  
  def show
    @giro = Giro.find(params[:id])
    @tappe = @giro.tappe.includes(:scuola).order(:posizione)
    @scuola_ids = @tappe.map(&:scuola_id)
  end
  
  def new
    @giro = Giro.new
    
    if params[:scuola_ids].present?
      @scuole = Scuola.find(params[:scuola_ids])
      i = 0
      for s in @scuole do
        t = @giro.tappe.build(:scuola_id => s.id)
        t.posizione = i += 1
      end
    end
  end
  
  def create
    @giro = Giro.create(params[:giro])
    if @giro.save
      redirect_to @giro, :notice => "Giro inserita."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @giro = Giro.find(params[:id])
  end
  
  def update
    @giro = Giro.find(params[:id])
    if @giro.update_attributes(params[:giro])
      redirect_to @giro, :notice => "Giro aggiornato."
    else
      render :action => 'edit'
    end
  end  
  
  def destroy
    @giro = Giro.find(params[:id])
    @giro.destroy
    redirect_to giri_url, :notice => "Giro eliminato!!!"
  end
    
end
