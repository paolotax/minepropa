class TagsController < ApplicationController
  
  def index
    
    @data = []
    
    @create_tag = Tag.where("name = ?", "#{params[:q]}")
    @data << { :id => "CREATE_#{params[:q]}_END", :name => "nuovo tag: #{params[:q]}" } if @create_tag.empty?
    
    @tags = Tag.where("name like ?", "%#{params[:q]}%")
    
    @matched_tags = @tags.map(&:attributes)
    for m in @matched_tags do
      @data << m
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => @data }
    end
  end
  
  def appunti_cloud
    @title  = params[:id]
    @appunti = current_user.appunti.in_corso.order('id desc').tagged_with(params[:id])
    @tags    = current_user.appunti.in_corso.order('id desc').tag_counts_on(:tags)
  end
end