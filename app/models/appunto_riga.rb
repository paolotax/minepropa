# == Schema Information
# Schema version: 20110517131235
#
# Table name: appunto_righe
#
#  id         :integer         not null, primary key
#  libro_id   :integer
#  appunto_id :integer
#  quantita   :integer
#  prezzo     :decimal(8, 2)
#  sconto     :decimal(3, 2)
#  consegnato :boolean
#  pagato     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class AppuntoRiga < ActiveRecord::Base
  belongs_to :libro
  belongs_to :appunto
  
  scope :da_consegnare, where("appunto_righe.consegnato = false OR appunto_righe.consegnato IS NULL")
  scope :consegnati,    where("appunto_righe.consegnato = true")
  scope :pagati,        where("appunto_righe.pagato = true")
  scope :da_pagare,     where("appunto_righe.pagato = false OR appunto_righe.pagato IS NULL")
    
  def valore
    libro.copertina * quantita unless libro.nil?
  end
  
  def titolo
    "#{libro.titolo}" unless libro.nil?
  end
  
  def price(string)
    re = /(e\s[\d,]+)|([\d,]+\s%)/
    m = re.match string
    
    
    m[0]
  end
  
  def copertina
    libro.copertina unless libro.nil?
  end
  
  def importo
    if prezzo.blank?
      if sconto.blank?
        libro.copertina * quantita
      else
        (libro.copertina - ( libro.copertina / 100 * sconto )) * quantita
      end
    else
      prezzo * quantita
    end  
  end

end
