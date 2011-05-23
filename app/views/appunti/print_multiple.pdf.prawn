   
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
      pdf.text appunto.destinatario, :size => 16, :style => :bold, :spacing => 4
      pdf.text appunto.scuola.nome_scuola, :size => 12, :spacing => 16
      pdf.text appunto.scuola.citta + " " + appunto.scuola.provincia, :size => 12
    end
  end

  pdf.move_down(350)
  pdf.text appunto.note, :size => 12
  pdf.move_down(20)
  pdf.text appunto.telefono unless appunto.telefono.nil?
  
  pdf.move_down(20)
  righe = appunto.appunto_righe.map do |riga|
    [
      riga.libro.titolo,
      riga.quantita,
      number_to_currency(riga.prezzo),
      number_to_currency(riga.importo)
    ]
  end

  pdf.table righe, :border_style => :grid,
    :row_colors => ["FFFFFF","DDDDDD"],
    :headers => ["Titolo", "Qtà", "Prezzo Uni", "Importo"],
    :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right }

  pdf.move_down(10)

  pdf.text "Totale: #{number_to_currency(appunto.appunto_righe.sum('appunto_righe.quantita * appunto_righe.prezzo'))}", :size => 16, :style => :bold
  
  pdf.move_down(350)
  
  pdf.start_new_page unless appunto == @appunti.last
end

