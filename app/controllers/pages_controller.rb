class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
    @search = current_user.appunti.in_corso.per_id.search(params[:search])
    
    
    if mobile_device?
      @appunti = @search.all
    else  
      @appunti = @search.paginate(:per_page => 8, :page => params[:page])
    end
  end

  def about
    @appunti = current_user.appunti.con_recapito.per_destinatario
  end

end
