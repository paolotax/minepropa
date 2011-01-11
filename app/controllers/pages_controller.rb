class PagesController < ApplicationController
  def home
    @title = "Home"
    @appunti = Appunto.in_corso.paginate(:per_page => 8, :page => params[:page])
  end

  def about
  end

end
