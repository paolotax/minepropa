class AdozioniController < ApplicationController

  def index
    @adozioni = Adozione.all
  end


  def show
    @adozione = Adozione.find(params[:id])
  end


  def new
    @adozione = Adozione.new
    @scuola = Scuola.find(params[:scuola_id]) if params[:scuola_id].present?
    @classi = @scuola.classi unless @scuola.nil?
    @libri  = Libro.unscoped.where("libri.type in ('Scolastico', 'Concorrenza')").order('libri.type desc, libri.titolo asc')
  end


  def create
    @adozione = Adozione.new(params[:adozione])

    respond_to do |format|
      if @adozione.save
        format.html { redirect_to(@adozione.classe.scuola, :notice => 'Adozione was successfully created.') }
      else
        format.html { redirect_to(new_scuola_adozione_url) }
      end
    end
  end


  def update
    @adozione = Adozione.find(params[:id])

    respond_to do |format|
      if @adozione.update_attributes(params[:adozione])
        format.html { redirect_to(@adozione, :notice => 'Adozione was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @adozione = Adozione.find(params[:id])
    @adozione.destroy

    respond_to do |format|
      format.html { redirect_to(scuola_url(@adozione.classe.scuola)) }
    end
  end
  
  
  def edit_individual
    @adozioni = Adozione.includes([[:classe => :scuola], :libro]).find(params[:adozione_ids])
    @scuola = Scuola.first
  end
  

  def update_individual
    @adozioni = Adozione.update(params[:adozioni].keys, params[:adozioni].values).reject { |p| p.errors.empty? }

    if @adozioni.empty? 
      @classe = Classe.find(params[:adozioni].values[0][:classe_id])
      redirect_to scuola_path(@classe.scuola_id), :notice => "Adozioni modificate"
    else
      render :action => "edit_individual"
    end
  end
  
end
