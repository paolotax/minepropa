module ApplicationHelper
  
  def sortable(column, title = nil)  
    title ||= column.titleize 
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}  
  end 
  
  def link_to_icon(icon_name, url_or_object, options={})
    options.merge!({ :class => "icon #{icon_name}" })

    link_to(image_tag("icons/#{icon_name}.png", { :title => icon_name }),
                      url_or_object,
                      options)
  end

  def tab_link(name, url)
    selected = url.all? { |key, value| params[key] == value }
    link_to(name, url, :class => (selected ? "selected tab" : "tab"))
  end
  
  def search_url(controller)
  
    if controller == 'pages'
      # need a refactoring
      if @current_action == 'home'
        return root_url
      elsif @current_action == 'about'  
        return about_url
      elsif @current_action == 'calendar'
        return calendar_url
      else
        return appunti_url
      end
    end
  end
  
  def link_to_current_with_class(name, current_class, options = {}, html_options = {}, &block)
    link_to_unless_current(name, options, html_options) do
      html_options[:class] = current_class + " " + html_options[:class]
      
      link_to(options, html_options) do
        haml_tag :span, name
        haml_tag :span, 0, :class => 'counter'
      end
    end
  end
  

  def get_provincia_link(provincia) 
    
    content_tag :li, :class => 'provincia' do
      link_to(params.merge(:provincia => provincia), :class => provincia.downcase) do
        haml_tag :img, src: "images/ajax-loader-bg-white.gif", style: "display:none;", class: "navigation-loader"
        haml_tag :span, provincia
        haml_tag :span, 0, :class => 'counter'
        #link_to_current_with_class(provincia, "active", params.merge(:provincia => provincia), :class => provincia.downcase)
      end
    end
  end
  
  
  
  def get_citta_user
    @citta = current_user.scuole.select('distinct citta')
  end
  
end
