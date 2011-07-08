class FattureController < ApplicationController

  def index
    @fatture = Fattura.all
    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def show
    @fattura = Fattura.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @scuola = Scuola.find(params[:scuola])
    @fattura = Fattura.new({:scuola => @scuola, :user => current_user})
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
    @fattura = Fattura.new(params[:fattura])
    @fattura.add_righe_from_scuola(@fattura.scuola)
    
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
