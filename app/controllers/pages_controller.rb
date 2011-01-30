class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
    @appunti = current_user.appunti.in_corso.search(params).provincia(params).paginate(:per_page => 8, :page => params[:page])
  end

  def about
    @appunti = current_user.appunti.in_corso.paginate(:per_page => 8, :page => params[:page])
  end

end
