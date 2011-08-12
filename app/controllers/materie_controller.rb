class MaterieController < ApplicationController
  # GET /materie
  # GET /materie.xml
  def index
    @materie = Materia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @materie }
    end
  end

  # GET /materie/1
  # GET /materie/1.xml
  def show
    @materia = Materia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @materia }
    end
  end

  # GET /materie/new
  # GET /materie/new.xml
  def new
    @materia = Materia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @materia }
    end
  end

  # GET /materie/1/edit
  def edit
    @materia = Materia.find(params[:id])
  end

  # POST /materie
  # POST /materie.xml
  def create
    @materia = Materia.new(params[:materia])

    respond_to do |format|
      if @materia.save
        format.html { redirect_to(@materia, :notice => 'Materia was successfully created.') }
        format.xml  { render :xml => @materia, :status => :created, :location => @materia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @materia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /materie/1
  # PUT /materie/1.xml
  def update
    @materia = Materia.find(params[:id])

    respond_to do |format|
      if @materia.update_attributes(params[:materia])
        format.html { redirect_to(@materia, :notice => 'Materia was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @materia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /materie/1
  # DELETE /materie/1.xml
  def destroy
    @materia = Materia.find(params[:id])
    @materia.destroy

    respond_to do |format|
      format.html { redirect_to(materie_url) }
      format.xml  { head :ok }
    end
  end
end
