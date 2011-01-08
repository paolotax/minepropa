prawn_document() do |pdf|
  
  pdf.float do
    pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top], :width => 100 do
      pdf.text current_user.email unless current_user.nil? 
    end
  end

  pdf.text "Hello world again"

  pdf.font "Helvetica"
  
  pdf.float do
    pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top], :width => 300 do
      pdf.move_down(150)
      pdf.text @appunto.destinatario, :size => 16, :style => :bold, :spacing => 4
      pdf.text @appunto.scuola.nome_scuola, :spacing => 16
      pdf.text @appunto.scuola.citta + " " + @appunto.scuola.provincia
    end
  end
  
  pdf.move_down(350)
  pdf.text @appunto.note
end