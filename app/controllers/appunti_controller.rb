class AppuntiController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }

  autocomplete :scuola, :nome_scuola
  
  before_filter :authenticate_user!
    
  helper_method :sort_column, :sort_direction
  
  def get_items(parameters)
    Scuola.where(:user_id => current_user.id).where(['nome_scuola LIKE ?', "%#{parameters[:term]}%"]).limit(10).order(:nome_scuola)
  end
  
  def index
    if mobile_device?
      @search = current_user.appunti.per_id.search(params[:search])  
      @appunti = @search.all
    else
      @search = current_user.appunti.per_id.page(params[:page]).per(30).search(params[:search])  
      @appunti = @search.relation
    end
  end
  
  def show
    @appunto = Appunto.find(params[:id])
    @visita = Visita.new
    
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @appunto }
      format.pdf   { render = false }
    end
  end

  def new
    @appunto   = current_user.appunti.build
    @indirizzo = @appunto.indirizzi.build
  end

  def edit
    @appunto = current_user.appunti.find(params[:id])
    @indirizzo = @appunto.indirizzi.first
    if @indirizzo == nil
      @indirizzo = @appunto.indirizzi.build
    end
  end
  
  def create
    @user = current_user
    @appunto = @user.appunti.build(params[:appunto])

    respond_to do |format|
      if @appunto.save
        format.mobile { redirect_to root_path }
        format.html   { redirect_to [@appunto], :flash => { :success => "L'appunto e' stato creato.  #{undo_link}" } }
        format.json   { render :json => @appunto, :status => :created, :location => @appunto }
      else
        format.mobile { render :action => 'new' }
        format.html   { render :action => "new" }
        format.json   { render :json => @appunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    #raise params.inspect
    @appunto = Appunto.find(params[:id])
    
    respond_to do |format|
      if @appunto.update_attributes(params[:appunto])
        format.mobile { redirect_to root_path }
        format.html   { redirect_to [@appunto], :flash => { :success => "L'appunto e' stato aggiornato.  #{undo_link}" } }
        format.json   { head :ok }
      else
        format.mobile { render :action => 'edit' }
        format.html   { render :action => "edit" }
        format.json   { render :json => @appunto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_user
    @appunto = @user.appunti.find(params[:id])
    @appunto.destroy

    respond_to do |format|
      format.mobile { redirect_to root_path }
      format.html   { redirect_to( appunti_url, :notice => "Appunto eliminato!  #{undo_link}") }
      format.json   { head :ok }
    end
  end

  def toggle_stato
    #raise params[:new_stato].inspect
    @appunto = Appunto.find(params[:id])
    
    if @appunto.stato == 'X'
      @appunto.stato = "P"
    else
      if @appunto.stato == ''
        @appunto.stato = "X"
      else
        if @appunto.stato == 'P'
          @appunto.stato = ""
        end
      end
    end
      
    respond_to do |format|
      if @appunto.save
        format.mobile { redirect_to root_path }
        format.html { redirect_to @appunto, :flash => { :success => "Le modifiche sono state salvate." } }
        format.xml  { head :ok }
        format.js
      else
        format.mobile { render :action => 'edit' }
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appunto.errors, :status => :unprocessable_entity }
        format.json  { render :json => @appunto.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit_or_print
    
    @appunti = Appunto.find(params[:appunti_ids])
    render 'print_multiple.pdf'
    
    # if params[:commit] == 'modifica selezionati'
    #   render 'edit_multiple'
    # else
    #   if params[:commit] == 'stampa selezionati'
    #     render 'print_multiple.pdf'
    #   end
    # end
  end
  
  def edit_multiple
    @appunti = Appunto.find(params[:appunti_ids])
    render 'edit_multiple'
  end
  
  def update_multiple
    @appunti = Appunto.find(params[:appunti_ids])
    @appunti.each do |a|
      a.update_attributes!(params[:appunto].reject { |k,v| v.blank? })  #  unless k == 'stato'
    end
    flash[:notice => "Updated"]
    redirect_to appunti_path
  end
  
  def print_multiple
    #raise params.inspect
    @appunti = Appunto.find(params[:appunti_ids])
    render 'print_multiple.pdf'
  end    
  
  private  

    def sort_column  
      Appunto.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
    end  
    
    def sort_direction  
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
    end 
    
    def undo_link
      view_context.link_to("annulla", revert_version_path(@appunto.versions.scoped.last), :method => :post)
    end 

end
