class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home

    if mobile_device?
      @search = current_user.appunti.in_corso.per_id.search(params[:search])
      @appunti = @search.all
    else
      @search = current_user.appunti.in_corso.per_id.page(params[:page]).per(8).search(params[:search])
      @appunti = @search.relation
    end

  end

  def about
    @search = current_user.appunti.in_corso.per_id.non_assegnato.search(params[:search])
    @appunti = @search.all
    
    #@appunti = current_user.appunti.in_corso.per_id.non_assegnato
    
    #@scuole = Scuola.con_appunti_in_corso(current_user)
    #@visite = Visita.all
  end

end
