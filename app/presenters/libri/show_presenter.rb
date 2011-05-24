class Libri::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(libro)
    @libro = libro
  end
  
  def da_consegnare
    @libro.appunto_righe.da_consegnare
  end
  
  def da_pagare
    @libro.appunto_righe.da_pagare
  end
  
  def consegnati
    @libro.appunto_righe.consegnati
  end
  
  def consegnati_da_pagare
    @libro.appunto_righe.consegnati.da_pagare
  end
  
  def consegnati_pagati
    @libro.appunto_righe.consegnati.pagati
  end
  
  memoize :da_consegnare, :da_pagare, :consegnati, :consegnati_da_pagare, :consegnati_pagati
end