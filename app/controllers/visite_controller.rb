class VisiteController < ApplicationController
  
  
  def index
    @visitable = find_visitable
    @visite = @visitable.visite
    respond_to do |format|  
      format.json { render :json => @visite }
    end
  end
  
  def show
    @visita = Visita.find(params[:id])
  end

  def new
    @visita = Visita..new
  end

  def create
    #raise params.inspect
    
    @visitable = find_visitable
    @visita = @visitable.visite.build(params[:visita])
    if @visita.save
      
      respond_to do |format|
        format.html { redirect_to about_url, :flash => { :success => "L'appunto e' stato creato." } }
        format.json { render :json => @visita }
        format.js
      end
            
    else
      render :action => 'new'
    end
  end

  def edit
    @visita = Visita.find(params[:id])
  end

  def update
    @visita = Visita.find(params[:id])
    if @visita.update_attributes(params[:visita])
      flash[:notice] = "Successfully updated visita."
      redirect_to @visita
    else
      render :action => 'edit'
    end
  end

  def destroy
    # raise params.inspect
    @visitable = find_visitable
    @visita = Visita.find(params[:id])
    @visita.destroy
    #flash[:notice] = "Successfully destroyed comment."
    respond_to do |format|
      format.html { redirect_to about_url, :flash => { :success => "L'appunto e' stato creato." } }
      format.js
      format.json { render :json => @visita}
    end
  end
  
  private

    def find_visitable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end

end
