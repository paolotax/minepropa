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
    @appunti    = current_user.appunti.includes(:appunto_righe).order('id desc').tagged_with(params[:id])
    
    @appunto_righe = AppuntoRiga.where("appunto_righe.appunto_id in (?) ", @appunti.collect(&:id))
    @fabbisogno = AppuntoRiga.
                        joins(:libro).
                        where("appunto_righe.appunto_id in (?) and (appunto_righe.consegnato = false or appunto_righe.consegnato is null)", @appunti.collect(&:id)).
                        group("appunto_righe.libro_id, libri.titolo").
                        select("appunto_righe.libro_id, libri.titolo, sum(quantita) as quantita").
                        order(:libro_id).collect{|fabb|[fabb.libro_id, fabb.titolo, fabb.quantita]}

    
    
    @tags       = current_user.appunti.in_corso.order('id desc').tag_counts_on(:tags)
  end
end


