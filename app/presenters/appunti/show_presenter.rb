class Appunto::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(appunto)
    @appunto = appunto
  end
  
  def appunto_righe
    @appunto.appunto_righe.in_corso.per_id
  end
  
  def appunti_da_pagare
    @scuola.appunti.per_id
  end
  
  def copie_per_scuola
    AppuntoRiga.joins(:appunto).where("appunti.scuola_id = ?", @scuola.id).sum(:quantita)
  end
    
  
  memoize :appunti_da_pagare, :appunti_in_corso, :copie_per_scuola

end