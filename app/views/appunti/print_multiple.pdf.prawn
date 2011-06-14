   
@appunti.each do |appunto|
  
  stef = "#{RAILS_ROOT}/public/images/giunti_scuola.jpg"
  pdf.image stef, :at => [0, 790], :width => 200, :height => 35
  
  pdf.font_size = 10
  pdf.line_width = 0.02

  pdf.move_down 10
  pdf.text "Agente di Zona - #{current_user.name}", :size => 13, :align => :right unless current_user.nil?
  pdf.text "Via Zanardi 376/2",  :align => :right
  pdf.text "40131 Bologna BO",   :align => :right
  pdf.move_down 10
  pdf.text "tel 051 6342585  fax 051 6341521", :align => :right
  pdf.text "cell #{current_user.phone}", :align => :right unless current_user.nil?

  pdf.text "email #{current_user.email}", :align => :right unless current_user.nil?
  pdf.move_down 8

  pdf.float do
    pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top], :width => 300 do
      pdf.move_down(200)
      pdf.text appunto.destinatario, :size => 12, :spacing => 4
      
      if !appunto.scuola.indirizzi.empty?
        indirizzo = appunto.scuola.indirizzi.first
        pdf.text indirizzo.destinatario,  :size => 14, :style => :bold, :spacing => 4
        pdf.text indirizzo.indirizzo
        pdf.text indirizzo.cap + ' ' + indirizzo.citta + ' ' + indirizzo.provincia
        # non funziona to_s carriage return 
        # pdf.text appunto.scuola.indirizzi.first.to_s unless appunto.scuola.indirizzi.empty? 
      else
        pdf.text appunto.scuola.nome_scuola, :size => 14, :style => :bold, :spacing => 16
        pdf.text appunto.scuola.citta + " " + appunto.scuola.provincia, :size => 12
      end
    end
  end

  pdf.move_down(200)
  pdf.text appunto.note, :size => 12
  pdf.move_down(20)
  pdf.text "tel. " + appunto.telefono unless appunto.telefono.nil?
  pdf.move_down(20)
  pdf.text "Consegna del " + l(Time.now, :format => :only_date), :size => 14, :style => :bold
    pdf.move_down(20)
  pdf.text "Ordine del " + l(appunto.created_at, :format => :only_date), :size => 14
  pdf.move_down(20)
  
  
  unless appunto.appunto_righe.empty?
    pdf.move_down(20)
    righe = appunto.appunto_righe.per_libro_id.map do |riga|
     [
        riga.libro.titolo,
        riga.libro.copertina,
        riga.quantita,
        riga.unitario,
        number_to_currency(riga.importo)
      ]
    end

    pdf.table righe, :border_style => :grid,
      :row_colors => ["FFFFFF","DDDDDD"],
      :headers => ["Titolo", "Quantità", "Pr.Copertina", "Prezzo", "Importo"],
      :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right }

    pdf.move_down(10)
    
     pdf.text "Totale copie: #{appunto.totale_copie}", :size => 14, :style => :bold
     pdf.text "Totale importo: #{number_to_currency((appunto.totale_importo))}", :size => 14, :style => :bold
  end
  
  pdf.move_down(350)
  
  pdf.start_new_page unless appunto == @appunti.last
end

