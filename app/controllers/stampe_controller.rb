class StampeController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }
  
  def sovrapacchi_adozioni
    
    @scuola = Scuola.find(params[:id])
    
    @adozioni = @scuola.adozioni.includes(:classe).scolastico.order("classi.classe, libri.id, classi.sezione")
    
    render 'sovrapacchi_adozioni.pdf'
 end

end
