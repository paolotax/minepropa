class Libri::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(libro, user)
    @libro = libro
    @user  = user
    @righe = @libro.appunto_righe.per_utente(@user).per_id
  end
  
  def da_consegnare
    @righe.da_consegnare
  end
  
  def da_pagare
    @righe.da_pagare
  end
  
  def consegnati
    @righe.consegnati
  end
  
  def consegnati_da_pagare
    @righe.consegnati.da_pagare
  end
  
  def consegnati_pagati
    @righe.consegnati.pagati
  end
  
  memoize :da_consegnare, :da_pagare, :consegnati, :consegnati_da_pagare, :consegnati_pagati
end