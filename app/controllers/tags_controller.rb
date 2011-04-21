class TagsController < ApplicationController

  def appunti_cloud
    @title  = params[:id]
    @appunti = current_user.appunti.in_corso.order('id desc').tagged_with(params[:id])
    @tags    = current_user.appunti.in_corso.order('id desc').tag_counts_on(:tags)
  end
end