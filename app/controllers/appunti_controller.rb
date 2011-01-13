class AppuntiController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }

  autocomplete :scuola, :nome_scuola, :full => true
  
  before_filter :authenticate_user!
    
  helper_method :sort_column, :sort_direction
  
  def index

    if params[:android]
      @appunti = Appunto.where("appunti.user_id = ?", current_user).search(params[:search], params[:user_id]).order(sort_column + ' ' + sort_direction)
    else  
      @appunti = Appunto.where("appunti.user_id = ?", current_user).search(params[:search], params[:user_id]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 8, :page => params[:page])
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
      format.pdf  { render = false }
    end
  end

  def new

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

  def toggle_stato
    #raise params[:new_stato].inspect
    appunto = Appunto.find(params[:id])
    
    if appunto.stato == 'X'
      appunto.stato = "P"
    else
      if appunto.stato == ''
        appunto.stato = "X"
      else
        if appunto.stato == 'P'
          appunto.stato = ""
        end
      end
    end
      
    appunto.save
    redirect_to appunti_path
  end
  
  def edit_or_print
    @appunti = Appunto.find(params[:appunti_ids])
    
    if params[:commit] == 'modifica selezionati'
      render 'edit_multiple'
    else
      if params[:commit] == 'stampa selezionati'
        render 'print_multiple.pdf'
      end
    end
  end
  
  # def edit_multiple
  #   #@appunti = Appunto.find(params[:appunti_ids])
  # end
  
  def update_multiple
    @appunti = Appunto.find(params[:appunti_ids])
    @appunti.each do |a|
      a.update_attributes!(params[:appunto].reject { |k,v| v.blank? unless k == 'stato'})
    end
    flash[:notice => "Updated"]
    redirect_to appunti_path
  end
  
  # def print_multiple
  #   #raise params.inspect
  #   #@appunti = Appunto.find(params[:appunti_ids])
  # end    
  
  private  

    def sort_column  
      Appunto.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
    end  
    
    def sort_direction  
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
    end  

end
