prawn_document() do |pdf|
  pdf.text @scuola.nome_scuola
  pdf.text @scuola.citta + " " + @scuola.provincia
end