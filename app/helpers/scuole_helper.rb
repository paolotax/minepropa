module ScuoleHelper
  
  
  def nested_scuole(scuole)
    scuole.map do |direzione, plessi|
      render(direzione) + content_tag(:div, nested_scuole(plessi), :class => "nested_scuole")
    end.join.html_safe
  end
  
end
