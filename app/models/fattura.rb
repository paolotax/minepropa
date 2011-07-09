# == Schema Information
# Schema version: 20110708083650
#
# Table name: fatture
#
#  id              :integer         not null, primary key
#  numero          :integer
#  data            :date
#  scuola_id       :integer
#  user_id         :integer
#  causale_id      :integer
#  dettaglio_righe :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class Fattura < ActiveRecord::Base
  belongs_to :scuola
  belongs_to :user
  has_many :appunto_righe, :dependent => :nullify
  
  TIPO_FATTURA = [ "Fattura", "Vendita" ]
  
  def add_righe_from_scuola(scuola) 
    scuola.appunti.each do |appunto|
      #riga.appunto_id = nil
      appunto.appunto_righe.each do |riga|
        self.appunto_righe << riga
      end
    end
  end
end
