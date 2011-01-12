class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
    @title = "Home"
    @appunti = Appunto.in_corso.paginate(:per_page => 8, :page => params[:page])
  end

  def about
  end

end
