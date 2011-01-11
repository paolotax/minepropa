  pdf.font_size = 10
  pdf.line_width = 0.02
  
  #pdf.bounding_box [5,700], :width => 550 do
    pdf.move_down 10
    pdf.text "Agente di Zona - PAOLO TASSINARI", :size => 13, :align => :right
    pdf.text "Via Zanardi 376/2",  :align => :right
    pdf.text "40131 Bologna BO",   :align => :right
    pdf.move_down 10
    pdf.text "tel 051 6342585  fax 051 6341521", :align => :right
    pdf.text "cell 347 2371680", :align => :right
    
    pdf.text "email #{current_user.email}", :align => :right unless current_user.nil?
    pdf.move_down 8

  
  #pdf.font "Helvetica"
  
  pdf.float do
    pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top], :width => 300 do
      pdf.move_down(200)
      pdf.text @appunto.destinatario, :size => 16, :style => :bold, :spacing => 4
      pdf.text @appunto.scuola.nome_scuola, :size => 12
      pdf.text @appunto.scuola.citta + " " + @appunto.scuola.provincia, :size => 12
    end
  end
  
  pdf.move_down(350)
  pdf.text @appunto.note, :size => 12
  
