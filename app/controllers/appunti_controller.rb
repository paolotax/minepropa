class AppuntiController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  # GET /appunti
  # GET /appunti.xml
  def index
    
    if params[:in_sospeso]
      @appunti = Appunto.in_sospeso.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 8, :page => params[:page])
    else
    
    if params[:android]
      @appunti = Appunto.search(params[:search]).order(sort_column + ' ' + sort_direction)
    else  
      @appunti = Appunto.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 8, :page => params[:page])
    end
    
    end
    # if params[:sort]
    #    @appunti = Appunto.order(params[:sort] + ' ' + params[:direction])
    # else
    #    @appunti = Appunto.order("created_at desc")
    # end
    
    # if params[:scuola]
    #    @appunti = @appunti.where("scuola like ?", '%' + params[:scuola] + '%')
    # end
    # if params[:destinatario]
    #    @appunti = @appunti.where("destinatario like ?", '%' + params[:destinatario] + '%')
    # end
    # if params[:cerca]
    #    @appunti = @appunti.where("destinatario like ? OR  scuola like ?", 
    #                               '%'+params[:cerca]+'%', '%'+params[:cerca]+'%')
    # end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appunti }
      format.json { render :json => @appunti }
    end
  end
  
  # def search
  # 
  #   #@products = Product.where("title like ?", '%' + params[:title] + '%')
  # 
  #   if params[:scuola]
  #     @appunti = @appunti.where("scuola like ?", '%' + params[:scuola] + '%')
  #   else
  #     @appunti = Appunto.all
  #   end
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @appunti }
  #     format.json  { render :json => @appunti }
  #   end
  # end

  # GET /appunti/1
  # GET /appunti/1.xml
  def show
    @appunto = Appunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appunto }
      format.json  { render :json => @appunto }
    end
  end

  # GET /appunti/new
  # GET /appunti/new.xml
  def new
    @appunto = Appunto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appunto }
      format.json  { render :json => @appunto }
    end
  end

  # GET /appunti/1/edit
  def edit
    @appunto = Appunto.find(params[:id])
  end

  # POST /appunti
  # POST /appunti.xml
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

  # PUT /appunti/1
  # PUT /appunti/1.xml
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

  # DELETE /appunti/1
  # DELETE /appunti/1.xml
  def destroy
    @appunto = Appunto.find(params[:id])
    @appunto.destroy

    respond_to do |format|
      format.html { redirect_to(appunti_url) }
      format.xml  { head :ok }
    end
  end
  
  private  
  def sort_column  
    Appunto.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
  end  
end
