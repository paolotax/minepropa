class AppuntoRigheController < ApplicationController
  # GET /appunto_righe
  # GET /appunto_righe.xml
  def index
    @appunto_righe = AppuntoRiga.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appunto_righe }
    end
  end

  # GET /appunto_righe/1
  # GET /appunto_righe/1.xml
  def show
    @appunto_riga = AppuntoRiga.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appunto_riga }
    end
  end

  # GET /appunto_righe/new
  # GET /appunto_righe/new.xml
  def new
    @appunto_riga = AppuntoRiga.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appunto_riga }
    end
  end

  # GET /appunto_righe/1/edit
  def edit
    @appunto_riga = AppuntoRiga.find(params[:id])
  end

  # POST /appunto_righe
  # POST /appunto_righe.xml
  def create
    @appunto_riga = AppuntoRiga.new(params[:appunto_riga])

    respond_to do |format|
      if @appunto_riga.save
        format.html { redirect_to(@appunto_riga, :notice => 'Appunto riga was successfully created.') }
        format.xml  { render :xml => @appunto_riga, :status => :created, :location => @appunto_riga }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @appunto_riga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /appunto_righe/1
  # PUT /appunto_righe/1.xml
  def update
    @appunto_riga = AppuntoRiga.find(params[:id])

    respond_to do |format|
      if @appunto_riga.update_attributes(params[:appunto_riga])
        format.html { redirect_to(@appunto_riga, :notice => 'Appunto riga was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appunto_riga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appunto_righe/1
  # DELETE /appunto_righe/1.xml
  def destroy
    @appunto_riga = AppuntoRiga.find(params[:id])
    @appunto_riga.destroy

    respond_to do |format|
      format.html { redirect_to(appunto_righe_url) }
      format.xml  { head :ok }
    end
  end
end
