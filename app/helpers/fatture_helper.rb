module FattureHelper
  
  
  def nested_righe_per_appunto(righe)
    
    righe.group_by(&:appunto).map do |a, righe|
      content_tag :div, :class => 'dettaglio_fattura' do
        content_tag( :div,  link_to( "Ordine del #{l a.created_at, :format => :short} - Consegna del #{a.tag_list} - copie #{a.totale_copie} - Importo #{a.totale_importo}", appunto_path(a)).html_safe, :class => 'consegna') +
        content_tag( :table, righe.collect{ |r| render :partial => 'fatture/fattura_riga', :locals => { :fattura_riga => r } }.join.html_safe, :class => 'dettagli')
      end
    end.join.html_safe
  end

end
