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
  
  def find_first_visita(id)
    appunto = Appunto.find(id)
    visita = appunto.visite.first
    if !visita.nil?
      h(visita.id) 
    else
     ''
    end
  end
  
  def appunto_edit_links(appunto)
    content_tag :div, :id => 'a_edit_buttons' do
      [ link_to_icon('show', appunto, :alt => 'elimina'),
        link_to_icon('edit', edit_appunto_path(appunto), :alt => 'elimina'),
        link_to_icon('destroy', appunto, { :method => :delete, :alt => 'elimina' } ),
        link_to_icon('print', appunto_path(appunto, :format => 'pdf'), :alt => 'elimina')
      ].join(' ').html_safe
    end
  end
  
  def get_posted_string(appunto)
    
    if appunto.stato == "X"
      return "Completato " + time_ago_in_words(appunto.updated_at) + " fa."
    else
      if appunto.created_at == appunto.updated_at
        return "Inserito "  + time_ago_in_words(appunto.created_at) + " fa." 
      else
        return "Aggiornato "  + time_ago_in_words(appunto.updated_at) + " fa."   
      end
    end
  end

end
