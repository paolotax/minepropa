class LibriController < ApplicationController

  def index
    @libri = Libro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @libri }
    end
  end

  def show
    @libro = Libro.find(params[:id])
    @presenter = Libri::ShowPresenter.new(@libro)
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /libri/new
  # GET /libri/new.xml
  def new
    @libro = Libro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @libro }
    end
  end

  # GET /libri/1/edit
  def edit
    @libro = Libro.find(params[:id])
  end

  # POST /libri
  # POST /libri.xml
  def create
    @libro = Libro.new(params[:libro])

    respond_to do |format|
      if @libro.save
        format.html { redirect_to(@libro, :notice => 'Libro was successfully created.') }
        format.xml  { render :xml => @libro, :status => :created, :location => @libro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @libro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /libri/1
  # PUT /libri/1.xml
  def update
    @libro = Libro.find(params[:id])

    respond_to do |format|
      if @libro.update_attributes(params[:libro])
        format.html { redirect_to(libri_path, :notice => 'Libro was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @libro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /libri/1
  # DELETE /libri/1.xml
  def destroy
    @libro = Libro.find(params[:id])
    @libro.destroy

    respond_to do |format|
      format.html { redirect_to(libri_url) }
      format.xml  { head :ok }
    end
  end
end
