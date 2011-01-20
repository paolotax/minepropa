class AppuntiController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }

  autocomplete :scuola, :nome_scuola, :full => true, :display_value => :funky_method
  
  before_filter :authenticate_user!
    
  helper_method :sort_column, :sort_direction
  
  def autocomplete_scuola_for_nome_scuola
     current_user.scuole.select(:name)
     # @scuole = current_user.scuole.where("nome_scuola like ?", "%"+params[:term]+"%").limit(10)
     # render @scuole
  end
  
  def index

    if params[:android]
      @appunti = current_user.appunti.search(params)
    else  
      @appunti = current_user.appunti.search(params).paginate(:per_page => 8, :page => params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @appunti }
    end
  end
  
  def show
    @appunto = Appunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @appunto }
      format.pdf  { render = false }
    end
  end

  def new

    @user = current_user
    @appunto = @user.appunti.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appunto }
      format.json  { render :json => @appunto }
    end
  end

  def edit
    @user = current_user
    @appunto = @user.appunti.find(params[:id])
  end

  def create
    @user = current_user
    @appunto = @user.appunti.build(params[:appunto])

    respond_to do |format|
      if @appunto.save
        format.html { redirect_to [current_user, @appunto], :flash => { :success => "L'appunto e' stato creato." } }
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
    @user = current_user
    @appunto = @user.appunti.find(params[:id])

    respond_to do |format|
      if @appunto.update_attributes(params[:appunto])
        format.html { redirect_to [current_user, @appunto], :flash => { :success => "Le modifiche sono state salvate." } }
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
    @user = current_user
    @appunto = @user.appunti.find(params[:id])
    @appunto.destroy

    respond_to do |format|
      format.html { redirect_to(appunti_url) }
      format.xml  { head :ok }
    end
  end

  def toggle_stato
    #raise params[:new_stato].inspect
    @user = current_user
    appunto = @user.appunti.find(params[:id])
    
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
    @user = current_user
    @appunto = @user.appunti.find(params[:appunti_ids])
    
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
    @user = current_user
    @appunto = @user.appunti.find(params[:appunti_ids])
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
