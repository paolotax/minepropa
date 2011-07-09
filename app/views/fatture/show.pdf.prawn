pdf.repeat :all do
    # header
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
      
      # logo = "#{RAILS_ROOT}/public/images/giunti_scuola.jpg"
      # pdf.image logo, :at => [pdf.bounds.left, pdf.bounds.top], :width => 200, :height => 35

      pdf.font_size = 10
      pdf.line_width = 0.02

      pdf.move_down 5
      pdf.text "#{current_user.name}", :size => 13 unless current_user.nil?
      pdf.text "Via Vestri, 4"
      pdf.text "40128 Bologna BO"
      pdf.move_down 5
      pdf.text "tel 051 6342585  fax 051 6341521"
      pdf.text "cell #{current_user.phone}" unless current_user.nil?
      pdf.text "email #{current_user.email}" unless current_user.nil?
    
      pdf.bounding_box [pdf.bounds.width / 2.0, pdf.bounds.top - 55.mm], :width => pdf.bounds.width / 2.0 do
        if !@scuola.indirizzi.empty?
          indirizzo = @scuola.indirizzi.first
          pdf.text 'Spett.Le', :size => 10
          pdf.text indirizzo.destinatario,  :size => 14, :style => :bold, :spacing => 4
          pdf.text indirizzo.indirizzo
          pdf.text indirizzo.cap + ' ' + indirizzo.citta + ' ' + indirizzo.provincia
        end
      end
      

      
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 55.mm], :width => 44.mm, :height => 8.mm do
        pdf.stroke_bounds
        pdf.text "FATTURA", :align => :center, :valign => :center
      end
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 63.mm], :width => 72.mm, :height => 8.mm do
        pdf.bounding_box [ pdf.bounds.left, pdf.bounds.top], :width => 8.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "PAG", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          
          # pagecount = pdf.page_count
          # pdf.text "#{pagecount}", :align => :center, :valign => :center, :size => 9
          
        end
        pdf.bounding_box [ pdf.bounds.left + 8.mm, pdf.bounds.top], :width => 18.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "DATA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "#{l(@fattura.created_at, :format => :only_date)}", :align => :center, :valign => :center, :size => 8
          end
        end
        pdf.bounding_box [pdf.bounds.left + 26.mm, pdf.bounds.top], :width => 18.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "NUMERO", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "#{@fattura.numero}", :align => :center, :valign => :center, :size => 8
          end
        end
        pdf.bounding_box [pdf.bounds.left + 44.mm, pdf.bounds.top], :width => 28.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "COD.CLIENTE", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
      end
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 71.mm], :width => 72.mm, :height => 8.mm do
        pdf.stroke_bounds
        pdf.draw_text "CONDIZIONI DI PAGAMENTO", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
      end
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 79.mm], :width => 72.mm, :height => 8.mm do
        pdf.bounding_box [ pdf.bounds.left, pdf.bounds.top], :width => 44.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "COD. FISCALE", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "#{@scuola.codice_fiscale}", :align => :center, :valign => :center, :size => 8
          end
        end
        pdf.bounding_box [ pdf.bounds.left + 44.mm, pdf.bounds.top], :width => 28.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "PARTITA IVA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "#{@scuola.partita_iva}", :align => :center, :valign => :center, :size => 8
          end
        end
      end
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 87.mm], :width => 72.mm, :height => 8.mm do
        pdf.bounding_box [ pdf.bounds.left, pdf.bounds.top], :width => 15.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "VALUTA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "EUR", :align => :center, :valign => :center, :size => 8
          end
        end
        pdf.bounding_box [ pdf.bounds.left + 15.mm, pdf.bounds.top], :width => 57.mm, :height => 8.mm do
          pdf.stroke_bounds
          pdf.draw_text "NOSTRO CODICE IBAN PER BONIFICI", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
          pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
            pdf.text "IT 04 1558 2037 ", :align => :center, :valign => :center, :size => 8
          end
        end
      end
      
            
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 95.mm], :width => pdf.bounds.width do
        pdf.table [["Titolo", "Prezzo Unitario", "Quantità", "Sconto", "Importo"]],
              :border_width   => 0.02,
              :font_size => 7,
              #:row_colors => ["FFFFFF","DDDDDD"],
              :column_widths => { 0 => 72.mm, 1 => 20.mm, 2 => 20.mm, 3 => 20.mm, 4 => 48.mm },
              :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right }
      end
    end

    # footer
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 55.mm], :width  => pdf.bounds.width do
        pdf.font "Helvetica"
        pdf.stroke_horizontal_rule
        pdf.move_down(5)
        pdf.text "And here's a sexy footer", :size => 16
    end
end


pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 108.mm], 
      :width  => pdf.bounds.width, :height => 124.mm) do
  
  unless @appunto_righe.empty?

    
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
        :border_width   => 0.02,
        :font_size => 8,
        #:row_colors => ["FFFFFF","DDDDDD"],
        :column_widths => { 0 => 72.mm, 1 => 20.mm, 2 => 20.mm, 3 => 20.mm, 4 => 48.mm },
        :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right }
      pdf.move_down(5)
    end
  end
end





