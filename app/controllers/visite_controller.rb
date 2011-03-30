class VisiteController < ApplicationController
  
  
  def index
    
    @visite = Visita.where('visite.start >= ?', Time.at(1301436000)).where('visite.end <= ?', Time.at(1301522400))
    
    @data = []
    @visite.each do |e|
      
      indirizzo =  e.visitable.scuola.indirizzi.first
      @data << { 
                :start    => e.start, 
                :end      => e.end, 
                :title    => e.visitable.destinatario + " " + e.visitable.scuola.nome_scuola, 
                :url      => appunto_path(e.visitable_id), 
                :allDay   => false, 
                :id       => 'appunto_' + e.visitable_id.to_s + '_visita_' + e.id.to_s,
                :latitude  => indirizzo.latitude.to_f,
                :longitude => indirizzo.longitude.to_f,
                :indirizzo => indirizzo.indirizzo,
                :indirizzo_completo => indirizzo.label_indirizzo
               }
    end
    
    respond_to do |format|
      format.json { render :json => @data }
    end
  end
  
  def show
    @visita = Visita.find(params[:id])
  end

  def new
    @visita = Visita.new
  end

  def create
    #raise params.inspect
    @visitable = find_visitable
    @visita = @visitable.visite.build(params[:visita])
    if @visita.save
      respond_to do |format|
        format.html { redirect_to about_url, :flash => { :success => "L'appunto e' stato creato." } }
        format.json { render :json => @visita }
        format.js
      end
    else
      format.html { render :action => 'new' }
      format.json {}
    end
  end

  def edit
    @visita = Visita.find(params[:id])
  end

  def update
    @visita = Visita.find(params[:id])
    if @visita.update_attributes(params[:visita])
      respond_to do |format|
        format.html { redirect_to about_url, :flash => { :success => "L'appunto e' stato aggiornato." } }
        format.json { render :json => @visita }
        format.js
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    # raise params.inspect
    @visita = Visita.find(params[:id])
    @visita.destroy
    #flash[:notice] = "Successfully destroyed comment."
    respond_to do |format|
      format.html { redirect_to about_url, :flash => { :success => "La visita e' stata eliminata" } }
      format.json { render :json => @visita }
      format.js
    end
  end
  
  private

    def find_visitable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

end
