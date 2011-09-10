class StampeController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }
  
  def sovrapacchi_adozioni
    
    @adozioni = Adozione.scolastico.joins([:classe => :scuola]).where("classi.scuola_id in (?)", params[:scuola_ids]).order("classi.classe, libri.id, classi.sezione")
    
    #@scuola = Scuola.find(params[:id])
    #@adozioni = @scuola.adozioni.includes(:classe).scolastico.order("classi.classe, libri.id, classi.sezione")
    render 'sovrapacchi_adozioni.pdf'
  end

  def riepilogo_adozioni
   
    @riepilogo = Libro.unscoped.
                  joins(:adozioni => [:classe => :scuola]).
                  select("libri.id, libri.titolo").
                  select('count (adozioni.*) as nr_sezioni').
                  where("libri.type = 'Scolastico'").
                  group("libri.id, libri.titolo").
                  where("scuole.id in (?)", params[:scuola_ids]).
                  order('libri.titolo')
   
  end
  
end
