class AdozioniController < ApplicationController
  # GET /adozioni
  # GET /adozioni.xml
  def index
    @adozioni = Adozione.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adozioni }
    end
  end

  # GET /adozioni/1
  # GET /adozioni/1.xml
  def show
    @adozione = Adozione.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adozione }
    end
  end

  # GET /adozioni/new
  # GET /adozioni/new.xml
  def new
    @adozione = Adozione.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adozione }
    end
  end

  # GET /adozioni/1/edit
  def edit
    @adozione = Adozione.find(params[:id])
  end

  # POST /adozioni
  # POST /adozioni.xml
  def create
    @adozione = Adozione.new(params[:adozione])

    respond_to do |format|
      if @adozione.save
        format.html { redirect_to(@adozione, :notice => 'Adozione was successfully created.') }
        format.xml  { render :xml => @adozione, :status => :created, :location => @adozione }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adozione.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adozioni/1
  # PUT /adozioni/1.xml
  def update
    @adozione = Adozione.find(params[:id])

    respond_to do |format|
      if @adozione.update_attributes(params[:adozione])
        format.html { redirect_to(@adozione, :notice => 'Adozione was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adozione.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adozioni/1
  # DELETE /adozioni/1.xml
  def destroy
    @adozione = Adozione.find(params[:id])
    @adozione.destroy

    respond_to do |format|
      format.html { redirect_to(adozioni_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit_individual
    @adozioni = Adozione.includes([[:classe => :scuola], :libro]).find(params[:adozione_ids])
    respond_to do |format|
      format.html
    end
  end

  def update_individual
    @adozioni = Adozione.update(params[:adozioni].keys, params[:adozioni].values).reject { |p| p.errors.empty? }
    if @adozioni.empty? 
          
      @classe = Classe.find(params[:adozioni].values[0][:classe_id])
      
      flash[:notice] = "Adozioni modificate"
      redirect_to scuola_path(@classe.scuola_id)
    else
      render :action => "edit_individual"
    end
  end
  
end
