class StampeController < ApplicationController
  
  prawnto :prawn => { :page_size => 'A4', :top_margin => 10 }
  
  def sovrapacchi_adozioni
    
    @scuola = Scuola.find(params[:id])
    
    @adozioni = @scuola.adozioni.includes(:classe).scolastico
    
    render 'sovrapacchi_adozioni.pdf'
 end

end
