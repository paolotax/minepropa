class UsersController < ApplicationController

  def show
    @user = current_user
    @appunti = current_user.appunti
    @scuole = current_user.scuole   
  end

end
