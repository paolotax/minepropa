# encoding: utf-8

class AppuntoPdf < Prawn::Document
  
  def initialize(appunto, view)
    super()
    @appunto = appunto
    @view = view
    @righe = appunto.appunto_righe
    intestazione
    destinatario
    appunto_number
    line_items unless @righe.blank?
    mess
    #     total_price
  end
  
  def mess
    # stroke_axis
    # line_to and curve_to
    stroke do
      move_to 0, 0
      line_to 100, 100
      line_to 0, 100
      curve_to [150, 250], :bounds => [[20, 200], [120, 200]]
      curve_to [200, 0], :bounds => [[150, 200], [450, 10]]
    end
    # line and curve
    stroke do
      line [300,200], [400,50]
      curve [500, 0], [400, 200], :bounds => [[600, 300], [300, 390]]
    end
  end
  
  def appunto_number
    text "ordine \##{@appunto.id} del #{l(@appunto.created_at)}", size: 16, style: :bold
  end
  
  def line_items
    table line_item_rows, :border_style => :grid,
                          :row_colors => ["FFFFFF","DDDDDD"],
                          :headers => ["Titolo", "Quantità", "Pr.Copertina", "Prezzo", "Importo"],
                          :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right },
                          :header => true
  end

  def line_item_rows
    @righe.per_libro_id.map do |item|
      [item.titolo, item.quantita, price(item.copertina), price(item.unitario), price(item.importo) ]
    end
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
  
  def l(data)
    @view.l(data,  :format => :only_date)
  end
  
  def total_price    
    move_down 15
    text "Total Price: #{price(@appunto.total_price)}", size: 16, style: :bold
  end
  
  def intestazione

    bounding_box([-10, 730], :width => 200, :height => 35) do
      #stroke_bounds
      stef = "#{RAILS_ROOT}/public/images/giunti_scuola.jpg"
      image stef, :width => 200, :height => 35
    end
    bounding_box([250, 730], :width => 300, :height => 100) do
      #stroke_bounds
      font_size 10
      text "Agente di Zona - #{current_user.name}", :size => 13, :align => :right unless current_user.nil?
      text "Via Zanardi 376/2",  :align => :right
      text "40131 Bologna BO",   :align => :right
      move_down 10
      text "tel 051 6342585  fax 051 6341521", :align => :right
      text "cell #{current_user.phone}", :align => :right unless current_user.nil?
      text "email #{current_user.email}", :align => :right unless current_user.nil?
      move_down 10
    end
  end
  
  def destinatario
    
    bounding_box [bounds.width / 2.0, bounds.top], :width => 300 do
      move_down(200)
      text @appunto.destinatario, :size => 12, :style => :bold, :spacing => 4

      if !@appunto.scuola.indirizzi.empty?
        indirizzo = @appunto.scuola.indirizzi.first
        text indirizzo.destinatario,  :size => 14, :style => :bold, :spacing => 4
        text indirizzo.indirizzo
        text indirizzo.cap + ' ' + indirizzo.citta + ' ' + indirizzo.provincia
        # non funziona to_s carriage return 
        # pdf.text appunto.scuola.indirizzi.first.to_s unless appunto.scuola.indirizzi.empty? 
      else
        text appunto.scuola.nome_scuola, :size => 14, :style => :bold, :spacing => 16
        text appunto.scuola.citta + " " + appunto.scuola.provincia, :size => 12
      end
    end
  end
  
  def current_user
    @view.current_user
  end
  
  
  
end


