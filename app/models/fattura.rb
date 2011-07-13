# == Schema Information
# Schema version: 20110710081331
#
# Table name: fatture
#
#  id                   :integer         not null, primary key
#  numero               :integer
#  data                 :date
#  scuola_id            :integer
#  user_id              :integer
#  causale_id           :integer
#  dettaglio_righe      :boolean
#  created_at           :datetime
#  updated_at           :datetime
#  condizioni_pagamento :string(255)
#  pagata               :boolean
#  totale_copie         :integer         default(0)
#  importo_fattura      :integer         default(0)
#  totale_iva           :integer         default(0)
#  currency             :string(255)
#

class Fattura < ActiveRecord::Base
  belongs_to :scuola
  belongs_to :user
  has_many :appunto_righe, :dependent => :nullify
  

  composed_of :importo,
      :class_name  => "Money",
      :mapping     => [%w(importo_fattura cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |importo_fattura, currency| Money.new(importo_fattura || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  composed_of :iva,
      :class_name  => "Money",
      :mapping     => [%w(totale_iva cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |totale_iva, currency| Money.new(totale_iva || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  TIPO_FATTURA = [ "Fattura", "Vendita" ]
  TIPO_PAGAMENTO = ["Contanti", "Assegno", "Bonifico Bancario", "Bollettino Postale"]
  
  def add_righe_from_scuola(scuola) 
    scuola.appunti.each do |appunto|
      #riga.appunto_id = nil
      appunto.appunto_righe.each do |riga|
        self.totale_copie += riga.quantita
        self.importo_fattura += riga.quantita * riga.prezzo_unitario
        self.appunto_righe << riga
      end
    end
  end
  
  def get_new_id(user)
    Fattura.where("user_id = ?", user.id).last == nil ? 1 : Fattura.where("user_id = ?", user.id).last[:numero] + 1  
  end
  
end
