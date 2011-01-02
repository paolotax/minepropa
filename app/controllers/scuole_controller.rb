class ScuoleController < ApplicationController
  # GET /scuole
  # GET /scuole.xml
  def index
    @scuole = Scuola.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scuole }
    end
  end

  # GET /scuole/1
  # GET /scuole/1.xml
  def show
    @scuola = Scuola.find(params[:id])
    @appunti = @scuola.appunti.all
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scuola }
      format.pdf { render :pdf => @scuola }
    end
  end

  # GET /scuole/new
  # GET /scuole/new.xml
  def new
    @scuola = Scuola.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scuola }
    end
  end

  # GET /scuole/1/edit
  def edit
    @scuola = Scuola.find(params[:id])
  end

  # POST /scuole
  # POST /scuole.xml
  def create
    @scuola = Scuola.new(params[:scuola])

    respond_to do |format|
      if @scuola.save
        format.html { redirect_to(@scuola, :notice => 'Scuola was successfully created.') }
        format.xml  { render :xml => @scuola, :status => :created, :location => @scuola }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scuola.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scuole/1
  # PUT /scuole/1.xml
  def update
    @scuola = Scuola.find(params[:id])

    respond_to do |format|
      if @scuola.update_attributes(params[:scuola])
        format.html { redirect_to(@scuola, :notice => 'Scuola was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scuola.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scuole/1
  # DELETE /scuole/1.xml
  def destroy
    @scuola = Scuola.find(params[:id])
    @scuola.destroy

    respond_to do |format|
      format.html { redirect_to(scuole_url) }
      format.xml  { head :ok }
    end
  end
end
