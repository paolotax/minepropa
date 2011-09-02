class ClassiController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @classi = Classe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classi }
    end
  end

  # GET /classi/1
  # GET /classi/1.xml
  def show
    @classe = Classe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classe }
    end
  end

  def new
    #raise params.inspect
    @classe = Classe.new
    @scuola = Scuola.find(params[:scuola_id]) if params[:scuola_id].present?

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @classe }
    end
  end

  def edit
    @classe = Classe.find(params[:id])
  end


  def create
    #raise params.inspect
    @scuola = Scuola.find(params[:scuola_id])
    @classe = @scuola.classi.build(params[:classe])

    respond_to do |format|
      if @classe.save
        format.html { redirect_to(scuola_url(@classe.scuola), :notice => 'Classe was successfully created.') }
        format.json  { render :json => @classe, :status => :created, :location => @classe }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @classe.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @classe = Classe.find(params[:id])

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
    @classe = Classe.find(params[:id])
    @classe.destroy

    respond_to do |format|
      format.html { redirect_to(classi_url) }
      format.json  { head :ok }
    end
  end
  
  def edit_individual
    @classi = Classe.includes(:scuola).find(params[:classe_ids])
    @scuola = @classi[0].scuola
    respond_to do |format|
      format.html
    end
  end

  def update_individual
    @classi = Classe.update(params[:classi].keys, params[:classi].values).reject { |p| p.errors.empty? }
    if @classi.empty?           
      flash[:notice] = "Classi modificate"
      redirect_to scuola_path(params[:classi].values[0][:scuola_id])
    else
      render :action => "edit_individual"
    end
  end
end
