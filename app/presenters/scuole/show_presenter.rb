class Scuole::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(scuola)
    @scuola = scuola
  end
  
  def appunti_in_corso
    @scuola.appunti.in_corso.per_id
  end
  
  def appunti_da_pagare
    @scuola.appunti.per_id
  end
  
  memoize :appunti_da_pagare, :appunti_in_corso

end