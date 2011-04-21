class TagsController < ApplicationController
  
  def index
    @tags = Tag.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @tags.map(&:attributes) }
    end
  end
  
  def appunti_cloud
    @title  = params[:id]
    @appunti = current_user.appunti.in_corso.order('id desc').tagged_with(params[:id])
    @tags    = current_user.appunti.in_corso.order('id desc').tag_counts_on(:tags)
  end
end