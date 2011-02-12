class VisiteController < ApplicationController
  
  
  def index
    @visitable = find_visitable
    @visite = @visitable.visite
  end
  
  def show
    @visita = Visita.find(params[:id])
  end

  def new
    @visita = Visita..new
  end

  def create
    @visitable = find_commentable
    @visita = @visitable.visite.build(params[:visita])
    if @visita.save
      flash[:notice] = "Successfully created visita."
      redirect_to :id => nil
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
    @visita = Visita.find(params[:id])
    @visita.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to visite_url
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
