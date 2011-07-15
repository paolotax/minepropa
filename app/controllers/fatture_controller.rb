class FattureController < ApplicationController
  
  require "prawn/measurement_extensions"
  
  before_filter :authenticate_user!
  
  prawnto :prawn => { :page_size => 'A4', :margin_top => 8.mm, :margin_bottom => 8.mm, :margin_left => 15.mm, :margin_right => 8.mm }

  def index
    @fatture = current_user.fatture.all
    
    @da_fatturare = Scuola.
                      joins(:appunti => :appunto_righe).
                      select("scuole.id, scuole.nome_scuola, scuole.provincia, appunti.stato").
                      select("count(distinct appunti.id) as count").
                      select("sum(appunto_righe.quantita) as copie").
                      select("sum(appunto_righe.quantita * appunto_righe.prezzo_unitario) as importo").
                      where("appunto_righe.fattura_id is null").
                      group("scuole.id, scuole.nome_scuola, scuole.provincia, appunti.stato").
                      order("scuole.provincia, scuole.nome_scuola")
    
    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def show
    @fattura = Fattura.find(params[:id])
    @scuola = @fattura.scuola
    @indirizzo = @scuola.indirizzi.first
    @appunto_righe = @fattura.appunto_righe.includes([:appunto, :libro]).per_appunto
    
    respond_to do |format|
      format.html # show.html.erb
      format.pdf { render :layout => false }
    end
  end

  def new
    @scuola = Scuola.find(params[:scuola])
    @fattura = Fattura.new({:scuola => @scuola, :user => current_user})
    @fattura.numero = @fattura.get_new_id(current_user)
    @fattura.data   = Time.now
    @appunto_righe = AppuntoRiga.includes([:appunto, :libro]).per_scuola(@scuola).da_fatturare.per_appunto
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fattura }
    end
  end

  # GET /fatture/1/edit
  def edit
    @fattura = Fattura.find(params[:id])
  end

  # POST /fatture
  # POST /fatture.xml
  def create
    #raise params.inspect
    @fattura = Fattura.new(params[:fattura])
    
    if params[:appunti_ids].nil?
      @fattura.add_righe_from_scuola(@fattura.scuola)
    else
      @fattura.add_righe_from_appunti(@fattura.scuola, params[:appunti_ids])
    end
    
    respond_to do |format|
      if @fattura.save
        format.html { redirect_to(@fattura, :notice => 'Fattura was successfully created.') }
        format.xml  { render :xml => @fattura, :status => :created, :location => @fattura }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fattura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fatture/1
  # PUT /fatture/1.xml
  def update
    @fattura = Fattura.find(params[:id])

    respond_to do |format|
      if @fattura.update_attributes(params[:fattura])
        format.html { redirect_to(@fattura, :notice => 'Fattura was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fattura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fatture/1
  # DELETE /fatture/1.xml
  def destroy
    @fattura = Fattura.find(params[:id])
    @fattura.destroy

    respond_to do |format|
      format.html { redirect_to(fatture_url) }
      format.xml  { head :ok }
    end
  end
end
