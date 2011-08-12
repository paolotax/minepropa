class ClassiController < ApplicationController
  # GET /classi
  # GET /classi.xml
  def index
    @classi = Classe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classi }
    end
  end

  # GET /classi/1
  # GET /classi/1.xml
  def show
    @classe = Classe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classe }
    end
  end

  # GET /classi/new
  # GET /classi/new.xml
  def new
    @classe = Classe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classe }
    end
  end

  # GET /classi/1/edit
  def edit
    @classe = Classe.find(params[:id])
  end

  # POST /classi
  # POST /classi.xml
  def create
    @classe = Classe.new(params[:classe])

    respond_to do |format|
      if @classe.save
        format.html { redirect_to(@classe, :notice => 'Classe was successfully created.') }
        format.xml  { render :xml => @classe, :status => :created, :location => @classe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /classi/1
  # PUT /classi/1.xml
  def update
    @classe = Classe.find(params[:id])

    respond_to do |format|
      if @classe.update_attributes(params[:classe])
        format.html { redirect_to(@classe, :notice => 'Classe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classi/1
  # DELETE /classi/1.xml
  def destroy
    @classe = Classe.find(params[:id])
    @classe.destroy

    respond_to do |format|
      format.html { redirect_to(classi_url) }
      format.xml  { head :ok }
    end
  end
end
