class AutocompleteSearchesController < ApplicationController
  #Rails 3

  respond_to :js
  
  def index
      @scuole = current_user.scuole.limit(10).search_for_nome(params[:term])
      respond_with(@scuole)
  end

end
