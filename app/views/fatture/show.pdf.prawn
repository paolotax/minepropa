pdf.repeat :all do
    # header
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
      
      # logo = "#{RAILS_ROOT}/public/images/giunti_scuola.jpg"
      # pdf.image logo, :at => [pdf.bounds.left, pdf.bounds.top], :width => 200, :height => 35

      pdf.font_size = 10
      pdf.line_width = 0.5

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
        pdf.table [["Titolo", "Quantità", "Prezzo Unitario", "% Sconto", "Importo", "IVA"]],
              :border_width   => 0.5,
              :font_size => 7,
              #:row_colors => ["FFFFFF","DDDDDD"],
              :column_widths => { 0 => 72.mm, 1 => 20.mm, 2 => 20.mm, 3 => 20.mm, 4 => 48.mm, 5 => 8.mm },
              :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right, 5 => :right }
      end
    end

    # footer
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 28.mm], :width  => pdf.bounds.width, :height => 50.mm do
    
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => 188.mm, :height => 24.mm do
        pdf.stroke_bounds
        
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => 32.mm, :height => 15.mm do
          pdf.stroke_bounds
          pdf.draw_text "IMPONIBILE", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 32.mm , pdf.bounds.top], :width  => 8.mm, :height => 15.mm do
          pdf.stroke_bounds
          pdf.draw_text "% IVA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 40.mm, pdf.bounds.top], :width  => 32.mm, :height => 15.mm do
          pdf.stroke_bounds
          pdf.draw_text "IMPOSTA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 72.mm, pdf.bounds.top], :width  => 108.mm, :height => 15.mm do

        end
        
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 15.mm], :width  => 40.mm, :height => 9.mm do
          pdf.stroke_bounds
          pdf.draw_text "TOT.INPONIBILE", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 40.mm, pdf.bounds.top - 15.mm], :width  => 32.mm, :height => 9.mm do
          pdf.stroke_bounds
          pdf.draw_text "TOTALE IMPOSTA", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 72.mm, pdf.bounds.top - 15.mm], :width  => 32.mm, :height => 9.mm do
          pdf.stroke_bounds
          pdf.draw_text "SPESE DI PORTO E IMBALLO", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6
        end
        
        pdf.bounding_box [pdf.bounds.left + 144.mm, pdf.bounds.top - 13.mm], :width  => 44.mm, :height => 11.mm do
          pdf.stroke_bounds
          pdf.draw_text "TOTALE FATTURA   EUR", :at => [pdf.bounds.left + 1, pdf.bounds.top - 6], :size => 6, :style => :bold
        end
      end    
    end
end

pdf.repeat(:all, :dynamic => true) do
  pdf.draw_text page_number, :at => [pdf.bounds.left + 7, pdf.bounds.top - 69.mm]
end


#  TABLE
pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 106.mm], :width  => pdf.bounds.width, :height => 135.mm) do
  
  unless @appunto_righe.empty?

    
    @appunto_righe.group_by(&:appunto).each do |a, righe|
      pdf.text "Ordine del #{l a.created_at, :format => :short} - Consegna del #{a.tag_list}"
      r = righe.map do |riga|
        [
          riga.libro.titolo,
          riga.quantita,
          riga.libro.copertina,
          riga.sconto,
          number_to_currency(riga.importo),
          "VA"
        ]
      end
      pdf.table r, 
        #:border_style => :grid,
        :border_width   => 0.02,
        :font_size => 8,
        #:row_colors => ["FFFFFF","DDDDDD"],
        :column_widths => { 0 => 72.mm, 1 => 20.mm, 2 => 20.mm, 3 => 20.mm, 4 => 48.mm, 5 => 8.mm },
        :align  => { 0 => :left, 1 => :right, 2 => :right, 3 => :right, 4 => :right, 5 => :right }
      pdf.move_down(5)
    end
  end
end


#  FOOTER WITH TOTALS
pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 28.mm], :width  => pdf.bounds.width, :height => 50.mm do

  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => 188.mm, :height => 24.mm do
  
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => 32.mm, :height => 15.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "#{@fattura.importo}", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 32.mm , pdf.bounds.top], :width  => 8.mm, :height => 15.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "0 %", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 40.mm, pdf.bounds.top], :width  => 32.mm, :height => 15.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "0", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 72.mm, pdf.bounds.top], :width  => 108.mm, :height => 15.mm do
      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "VA: IVA ass.editore art.74.1.C", :align => :left, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 15.mm], :width  => 40.mm, :height => 9.mm do
      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "#{@fattura.importo}", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 40.mm, pdf.bounds.top - 15.mm], :width  => 32.mm, :height => 9.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "0,00", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 72.mm, pdf.bounds.top - 15.mm], :width  => 32.mm, :height => 9.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 6.mm do
        pdf.text "0,00", :align => :right, :valign => :center, :size => 8
      end
    end
    
    pdf.bounding_box [pdf.bounds.left + 144.mm, pdf.bounds.top - 13.mm], :width  => 44.mm, :height => 11.mm do

      pdf.bounding_box [ pdf.bounds.left + 1.mm, pdf.bounds.top - 2.mm ], :width => pdf.bounds.width - 2.mm, :height => 8.mm do
        pdf.text "#{@fattura.importo}", :align => :right, :valign => :center, :size => 8
      end
    end
  end    
end







