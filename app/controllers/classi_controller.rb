class ClassiController < ApplicationController

  before_filter :authenticate_user!
  
  before_filter :get_scuola
  
  def get_scuola
    @scuola = Scuola.find(params[:scuola_id])
  end
  
  def index
    @classi = @scuola.classi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @classi }
    end
  end

  def show
    @classe = @scuola.classi.find(params[:id])

    respond_to do |format|
      format.html
      format.json  { render json: @classe }
    end
  end

  def new
    @classe = @scuola.classi.new

    respond_to do |format|
      format.html
      format.json  { render json: @classe, location: @classe }
    end
  end

  def edit
    @classe = @scuola.classi.find(params[:id])
  end


  def create
    @classe = @scuola.classi.build(params[:classe])

    respond_to do |format|
      if @classe.save
        format.html { redirect_to(scuola_url(@classe.scuola), :notice => 'Classe was successfully created.') }
        format.json  { render :json => @classe, :status => :created, :location => @classe }
        format.js
      else
        format.html { render :action => "new" }
        format.json  { render :json => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @classe = @scuola.classi.find(params[:id])

    respond_to do |format|
      if @classe.update_attributes(params[:classe])
        format.html { redirect_to(@classe, :notice => 'Classe was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @classe = @scuola.classi.find(params[:id])
    @classe.destroy

    respond_to do |format|
      format.html { redirect_to(scuola_url(@classe.scuola)) }
      format.json  { head :ok }
      format.js
    end
  end
  
  def edit_individual
    @classi = @scuola.classi.order('classi.classe, classi.sezione')
  end

  def update_individual
    @classi = @scuola.classi.update(params[:classi].keys, params[:classi].values).reject { |p| p.errors.empty? }
    if @classi.empty?           
      flash[:notice] = "Classi modificate"
      redirect_to scuola_path(params[:classi].values[0][:scuola_id])
    else
      render :action => "edit_individual"
    end
  end
end
