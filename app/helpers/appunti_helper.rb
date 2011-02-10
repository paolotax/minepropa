module AppuntiHelper
  
  def show_status_icon(status)
    
    if status == 'X'
      return 's_comp_short.png'
    else
      if status == "P"
        return "s_sosp_short.png"
      else  
        return 's_blank_short.png'
      end
    end
  end
  
  def get_posted_string(appunto)
    
    if appunto.stato == "X"
      return "Completed " + time_ago_in_words(appunto.updated_at) + " ago."
    else
      if appunto.created_at == appunto.updated_at
        return "Posted "  + time_ago_in_words(appunto.created_at) + " ago." 
      else
        return "Updated "  + time_ago_in_words(appunto.updated_at) + " ago."   
      end
    end
  end
  
  def get_provincie_appunti
    @provincie = current_user.scuole.select('distinct provincia')
    # @provincie.each do |p|
    #   provincie << p
    # end
    # provincie
  end    
  
  def get_citta_appunti
    @citta = current_user.scuole.select('distinct citta')
    # @provincie.each do |p|
    #   provincie << p
    # end
    # provincie
  end  
end
