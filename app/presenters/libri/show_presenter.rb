class Libri::ShowPresenter
  
  extend ActiveSupport::Memoizable
  
  def initialize(libro, user)
    @libro = libro
    @user  = user
  end
  
  def da_consegnare
    @libro.appunto_righe.per_utente(@user).da_consegnare.per_id
  end
  
  def da_pagare
    @libro.appunto_righe.per_utente(@user).da_pagare.per_id
  end
  
  def consegnati
    @libro.appunto_righe.per_utente(@user).consegnati.per_id
  end
  
  def consegnati_da_pagare
    @libro.appunto_righe.per_utente(@user).consegnati.da_pagare.per_id
  end
  
  def consegnati_pagati
    @libro.appunto_righe.per_utente(@user).consegnati.pagati.per_id
  end
  
  memoize :da_consegnare, :da_pagare, :consegnati, :consegnati_da_pagare, :consegnati_pagati
end