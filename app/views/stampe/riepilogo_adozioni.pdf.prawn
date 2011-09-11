require 'prawn/graphics'
require "prawn/measurement_extensions"


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



pdf.move_down(20)
righe = @riepilogo.map do |riga|
 [
    riga.titolo,
    riga.numero_sezioni
  ]
end

pdf.table righe, :border_style => :grid,
  #:row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["Titolo", "Sezioni"],
  :align => { 0 => :left, 1 => :right }

pdf.move_down(10)




