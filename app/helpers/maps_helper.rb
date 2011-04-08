module MapsHelper
 
 
  # ORRENDO CICLO 
  def get_scuola_latlng(scuola_id)
    @indirizzo = Indirizzo.where('indirizzi.indirizzable_id = ? AND indirizzi.indirizzable_type = ?', scuola_id, "Scuola").first
    
    if (!@indirizzo.nil?)
      if (!@indirizzo.latitude.nil?) && (!@indirizzo.longitude.nil?)
        return @indirizzo.latitude + ',' + @indirizzo.longitude 
      else
        return ''
      end
    else
      return ''
    end
  end
    
end
