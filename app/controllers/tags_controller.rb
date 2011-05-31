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
    @title      = params[:id]
    @appunti    = current_user.appunti.in_corso.order('id desc').tagged_with(params[:id])
    
    @fabbisogno = AppuntoRiga
                    .where("appunto_righe.appunto_id in (?) and appunto_righe.consegnato = false", @appunti.collect(&:id))
                    .group(:libro_id)
                    .order(:libro_id)
                    .sum(:quantita)

    
    
    @tags       = current_user.appunti.in_corso.order('id desc').tag_counts_on(:tags)
  end
end


AppuntoRiga.where("appunto_righe.appunto_id in (?)", Appunto.in_corso.collect(&:id)).group(:libro_id).order(:libro_id).sum(:quantita)

