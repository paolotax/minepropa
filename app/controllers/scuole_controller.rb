class ScuoleController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @search = current_user.scuole.includes([:indirizzi, :giri]).per_id.search(params[:search])
    @scuole = @search.relation
    
    if params[:provincia].present?
      @scuole = @scuole.per_provincia(params[:provincia])
    end
        
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show

    @scuola = current_user.scuole.find(params[:id])    
    @presenter = Scuole::ShowPresenter.new(@scuola)

    # da eliminare ?
    @indirizzo = @scuola.indirizzi.first
    unless @indirizzo.nil?
      #@json  = @indirizzo.to_gmaps4rails
      @coord = @indirizzo.to_gomap_marker
    end
    
    #da eliminare ?
    @search = @scuola.appunti.page(params[:page]).per(8).search(params[:search])
    @appunti = @search.relation
 
    @grouped_adozioni = @scuola.get_adozioni
    @grouped_classi   = @scuola.get_classi
    
    respond_to do |format|
      format.html # show.html.erb
      format.js    { render :json => @indirizzo }
      format.json  { render :json => @coord }
      format.pdf   { render :pdf  => @scuola }
    end
  end

  def new
    
    session[:return_to] = request.referer
        
    @scuola    = Scuola.new
    @indirizzo = @scuola.indirizzi.build
  end

  def edit
    
    session[:return_to] = request.referer
    
    @scuola    = current_user.scuole.find(params[:id])
    @indirizzo = @scuola.indirizzi.first
    if @indirizzo == nil
      @indirizzo  = @scuola.indirizzi.build
    end
  end

  def create
    @scuola = current_user.scuole.build(params[:scuola])

    respond_to do |format|
      if @scuola.save
        format.html { redirect_to(session[:return_to], :notice => 'Scuola inserita.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @scuola = current_user.scuole.find(params[:id])

    respond_to do |format|
      if @scuola.update_attributes(params[:scuola])
        format.html { redirect_to(session[:return_to], :notice => 'Scuola modificata.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @scuola = Scuola.find(params[:id])
    @scuola.destroy

    respond_to do |format|
      format.html { redirect_to(scuole_url) }
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
