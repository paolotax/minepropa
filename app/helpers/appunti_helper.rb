module AppuntiHelper
  
  def show_status_icon(status)
    
    if status == 'X'
      return 's_completed18.png'
    else
      if status == "P"
        return "s_waiting18.png"
      else  
        return 's_blank.gif'
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
end
