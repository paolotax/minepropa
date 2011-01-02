prawn_document() do |pdf|
  pdf.text @appunto.destinatario
  pdf.text @appunto.scuola.nome_scuola
  pdf.text @appunto.scuola.citta + " " + @appunto.scuola.provincia
  
  pdf.move_down(10)
  pdf.text @appunto.note
end