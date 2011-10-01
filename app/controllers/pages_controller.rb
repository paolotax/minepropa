class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home

    if mobile_device?

      @search = current_user.appunti.includes([:appunti_righe, :scuola]).in_corso.per_id.search(params[:search])
      @appunti = @search.all
    else
      
      # @term = params[:search]
      # # @search = current_user.appunti.in_corso.per_id.page(params[:page]).per(30).search(params[:search])
      # @search = current_user.appunti.includes([:appunto_righe, :scuola, :visite, {:taggings => :tag}]).in_corso.per_id.search(params[:search])
      # @appunti = @search.relation
      
      @appunti = current_user.grouped_appunti_count
      @recent  = current_user.appunti.includes(:scuola).in_corso.per_id
      
      @tags = current_user.appunti.in_corso.tag_counts_on(:tags)
    end

  end
  
  def vendite

    if mobile_device?

      @search = current_user.appunti.includes([:appunti_righe, :scuola]).per_id.search(params[:search])
      @appunti = @search.all
    else
      @term = params[:search]
       # @search = current_user.appunti.in_corso.per_id.page(params[:page]).per(30).search(params[:search])
      @appunti  = current_user.appunti.joins(:scuola).includes([{:appunto_righe => :libro}, :taggings, :visite]).con_righe.per_scuola_id.per_id
      # @appunti = @search.relation
      @tags = current_user.appunti.in_corso.tag_counts_on(:tags)
    end

  end

  def about
    @search = current_user.appunti.in_corso.per_id.non_assegnato.search(params[:search])
    # @search = current_user.appunti.in_corso.per_id.non_assegnato.page(params[:page]).per(30).search(params[:search])
    @appunti = @search.relation
    
    @appunti_assegnati = current_user.appunti.in_corso.assegnato.all
    
    #@scuole = Scuola.con_appunti_in_corso(current_user)
    #@visite = Visita.all
  end
  
  def calendar
    @search = current_user.appunti.in_corso.per_id.non_assegnato.page(params[:page]).per(30).search(params[:search])
    @appunti = @search.relation
    
    @appunti_assegnati = current_user.appunti.assegnato.all
    
    #@scuole = Scuola.con_appunti_in_corso(current_user)
    #@visite = Visita.all
  end

end
