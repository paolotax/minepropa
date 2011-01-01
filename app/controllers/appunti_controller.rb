class AppuntiController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  
  def index
    @title = "Tutti gli appunti"
    
    if params[:android]
      @appunti = Appunto.search(params[:search]).order(sort_column + ' ' + sort_direction)
    else  
      @appunti = Appunto.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 8, :page => params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appunti }
      format.json { render :json => @appunti }
    end
  end
  
  def show
    @appunto = Appunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appunto }
      format.json  { render :json => @appunto }
    end
  end

  def new
    @title = "Nuovo appunto"
    
    @appunto = Appunto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appunto }
      format.json  { render :json => @appunto }
    end
  end

  def edit
    @appunto = Appunto.find(params[:id])
  end

  def create
    @appunto = Appunto.new(params[:appunto])

    respond_to do |format|
      if @appunto.save
        format.html { redirect_to(@appunto, :notice => 'Appunto was successfully created.') }
        format.xml  { render :xml => @appunto, :status => :created, :location => @appunto }
        format.json  { render :json => @appunto, :status => :created, :location => @appunto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @appunto.errors, :status => :unprocessable_entity }
        format.json  { render :json => @appunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @appunto = Appunto.find(params[:id])

    respond_to do |format|
      if @appunto.update_attributes(params[:appunto])
        format.html { redirect_to(@appunto, :notice => 'Appunto was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :json }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appunto.errors, :status => :unprocessable_entity }
        format.json  { render :json => @appunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @appunto = Appunto.find(params[:id])
    @appunto.destroy

    respond_to do |format|
      format.html { redirect_to(appunti_url) }
      format.xml  { head :ok }
    end
  end

  def complete
    Appunto.update_all(["appunti.stato=?", "X"], :id => params[:appunti_ids])
  end
    
  private  

    def sort_column  
      Appunto.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
    end  
    
    def sort_direction  
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
    end  

end
