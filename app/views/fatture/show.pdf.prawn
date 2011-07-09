pdf.repeat :all do
    # header
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width  do
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
      pdf.stroke_horizontal_rule
    end

    # footer
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 25], :width  => pdf.bounds.width do
        pdf.font "Helvetica"
        pdf.stroke_horizontal_rule
        pdf.move_down(5)
        pdf.text "And here's a sexy footer", :size => 16
    end
end


pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 130], 
      :width  => pdf.bounds.width, :height => pdf.bounds.height - 200) do
  
  pdf.move_down 2ß

  pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top], :width => 300 do
    if !@scuola.indirizzi.empty?
      indirizzo = @scuola.indirizzi.first
      pdf.text indirizzo.destinatario,  :size => 14, :style => :bold, :spacing => 4
      pdf.text indirizzo.indirizzo
      pdf.text indirizzo.cap + ' ' + indirizzo.citta + ' ' + indirizzo.provincia
      # non funziona to_s carriage return 
      # pdf.text appunto.scuola.indirizzi.first.to_s unless appunto.scuola.indirizzi.empty? 
    else
      # pdf.text appunto.scuola.nome_scuola, :size => 14, :style => :bold, :spacing => 16
      # pdf.text appunto.scuola.citta + " " + appunto.scuola.provincia, :size => 12
    end
  end


  pdf.move_down(50)
  pdf.text "Fattura nr. #{@fattura.numero} del #{l(@fattura.created_at, :format => :only_date)}", :size => 12
  pdf.move_down(50)

  unless @appunto_righe.empty?
    pdf.move_down(20)
  
    pdf.table [["Titolo", "Prezzo Unitario", "Quantità", "Sconto", "Importo"]],
          :position => :center,
          :border_width   => 0.02,
          :font_size => 10,
          #:row_colors => ["FFFFFF","DDDDDD"],
          :column_widths => { 0 => 200, 1 => 70, 2 => 70, 3 => 70, 4 => 150 },
          :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right }
    pdf.move_down(5)
    @appunto_righe.group_by(&:appunto).each do |a, righe|
      pdf.text "Ordine del #{l a.created_at, :format => :short} - Consegna del #{a.tag_list}"
      r = righe.map do |riga|
        [
          riga.libro.titolo,
          riga.libro.copertina,
          riga.quantita,
          riga.sconto,
          number_to_currency(riga.importo)
        ]
      end
      pdf.table r, 
        #:border_style => :grid,
        :position => :center,
        :border_width   => 0.02,
        :font_size => 10,
        #:row_colors => ["FFFFFF","DDDDDD"],
        :column_widths => { 0 => 200, 1 => 70, 2 => 70, 3 => 70, 4 => 150 },
        :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right }
      pdf.move_down(5)
    end
  end
end





