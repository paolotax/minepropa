class IndirizziController < ApplicationController

  def index
    @indirizzable = find_indirizzable
    @indirizzo = @indirizzable.indirizzi
  end
  
  def show
    @indirizzo = Indirizzo.find(params[:id])
  end

  def new
    @indirizzo = Indirizzo.new
  end

  def create
    #raise params.inspect
    
    @indirizzable = find_indirizzable
    @indirizzo = @indirizzable.indirizzi.build(params[:indirizzo])
    if @indirizzo.save
      
      respond_to do |format|
        format.html { redirect_to about_url, :flash => { :success => "L'indirizzo e' stato creato." } }
        format.js
      end
            
    else
      render :action => 'new'
    end
  end

  def edit
    @indirizzo = Indirizzo.find(params[:id])
  end

  def update
    @indirizzo = Indirizzo.find(params[:id])
    if @indirizzo.update_attributes(params[:indirizzo])
      flash[:notice] = "Successfully updated indirizzo."
      redirect_to @indirizzo
    else
      render :action => 'edit'
    end
  end

  def destroy
    # raise params.inspect
    @indirizzable = find_indirizzable
    @indirizzo = Indirizzo.find(params[:id])
    @indirizzo.destroy
    #flash[:notice] = "Successfully destroyed comment."
    respond_to do |format|
      format.html { redirect_to about_url, :flash => { :success => "L'indirizzo e' stato creato." } }
      format.js
    end
  end
  
  private

    def find_indirizzable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
  
end
