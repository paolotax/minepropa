class GiriController < ApplicationController
  
  
  def index
    @giri = Giro.all
  end
  
  def show
    @giro = Giro.find(params[:id])
    @tappe = @giro.tappe.includes(:scuola)
    @scuola_ids = @tappe.map(&:scuola_id)
  end
  
  def new
    @giro = Giro.new
    @scuole = Scuola.find(params[:scuola_ids])
    i = 0
    for s in @scuole do
      t = @giro.tappe.build(:scuola_id => s.id)
      t.posizione = i += 1
    end
  end
  
  def create
    @giro = Giro.create(params[:giro])

    respond_to do |format|
      if @giro.save
        format.html { redirect_to( @giro, :notice => 'Scuola inserita.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @giro = Giro.find(params[:id])
  end
  
  def update
    @giro = Giro.find(params[:id])
    if @giro.update_attributes(params[:giro])
      flash[:notice] = "Giro aggiornato."
      redirect_to @giro
    else
      render :action => 'edit'
    end
  end  
  
  def destroy
    @giro = Giro.find(params[:id])
    @giro.destroy
    flash[:notice] = "Giro eliminato!!!"
    redirect_to giri_url
  end
    
end
