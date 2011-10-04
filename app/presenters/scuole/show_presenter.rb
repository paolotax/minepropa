class Scuole::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(scuola)
    @scuola = scuola
  end

  def appunti_da_fare
    @scuola.appunti.da_fare.per_id
  end
    
  def appunti_in_corso
    @scuola.appunti.in_corso.per_id
  end
  
  def appunti_da_pagare
    @scuola.appunti.in_sospeso.per_id
  end
  
  def appunti_completati
    @scuola.appunti.completati.per_id
  end
  
  def copie_per_scuola
    AppuntoRiga.joins(:appunto).where("appunti.scuola_id = ?", @scuola.id).sum(:quantita)
  end
  
  def riepilogo_venduto
    Libro.select("libri.id, libri.titolo, sum(appunto_righe.quantita) as copie, sum(appunto_righe.quantita * appunto_righe.prezzo_unitario) as importo").
          joins(:appunto_righe => [:appunto => :scuola]).
          group("libri.id, libri.titolo").
          where("scuole.id = ?", @scuola.id)
  
  end
  
  def totale_venduto
    AppuntoRiga.select("sum(appunto_righe.quantita) as copie, sum(appunto_righe.quantita * appunto_righe.prezzo_unitario) as sum_importo").           
                joins(:appunto => :scuola).where("scuole.id = ?", @scuola.id)
  end
    
  
  memoize :appunti_da_fare, :appunti_da_pagare, :appunti_in_corso, :appunti_completati, :copie_per_scuola, :riepilogo_venduto, :totale_venduto

end