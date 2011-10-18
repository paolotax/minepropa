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
  
  def search_url(controller)
  
    if controller == 'pages'
      
      # need a refactoring
      if @current_action == 'home'
        return root_url
      else
        if @current_action == 'about'  
          return about_url
        else
          if @current_action == 'calendar'
            return calendar_url
          end
        end  
      end
      
    else
      return appunti_url
    end
  end
  
  def link_to_provincia(provincia)
    if params[:provincia] == provincia
      "<span>#{provincia}</span>".html_safe
    else
      link_to provincia, params.merge(:provincia => provincia) #, :remote => true
    end
  end
  
  def get_provincia_link(provincia) 
    content_tag :li, :class => 'links' do
      link_to_provincia provincia
    end
    # if @current_controller == 'scuole' then
    #   content_tag :li, :class => 'links' do
    #     link_to provincia, scuole_url(:provincia => provincia), :remote => true
    #   end
    # else
    #   content_tag :li, :class => 'links' do
    #     link_to provincia, appunti_url(:provincia => provincia), :remote => true
    #   end      
    # end
  end
  
  
  
  def get_citta_user
    @citta = current_user.scuole.select('distinct citta')
    # @provincie.each do |p|
    #   provincie << p
    # end
    # provincie
  end
  
end
