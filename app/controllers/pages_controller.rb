class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
    @search = current_user.appunti.in_corso.per_id.search(params[:search])

    if mobile_device?
      @appunti = @search.all
    else
      @visita = Visita.new 
      @appunti = @search.paginate(:per_page => 8, :page => params[:page])
    end

  end

  def about
    @appunti = current_user.appunti.in_corso.per_id.non_assegnato
    @scuole = Scuola.con_appunti_in_corso(current_user)
    @visite = Visita.all
  end

end
