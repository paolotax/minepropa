class ScuoleController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @search = current_user.scuole.order('scuole.position asc').page(params[:page]).per(30).search(params[:search])
    @scuole = @search.relation
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @scuola = Scuola.find(params[:id])
   
    @search = @scuola.appunti.search(params[:search])
    @appunti = @search.page(params[:page]).per(8)

    #@appunti = @scuola.appunti.paginate(:per_page => 8, :page => params[:page])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scuola }
      format.pdf { render :pdf => @scuola }
    end
  end

  def new
    @scuola = Scuola.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scuola }
    end
  end

  def edit
    @scuola = Scuola.find(params[:id])
  end

  def create
    @scuola = current_user.scuole.build(params[:scuola])

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

  def destroy
    @scuola = Scuola.find(params[:id])
    @scuola.destroy

    respond_to do |format|
      format.html { redirect_to(scuole_url) }
      format.xml  { head :ok }
    end
  end

  def sort
    @scuole = current_user.scuole

    @scuole.each do |scuola|
      scuola.position = params[:scuola].index(scuola.id.to_s) + 1
      scuola.save
    end
    render :nothing => true
  end
end
