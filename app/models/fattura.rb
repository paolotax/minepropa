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
  has_many :appunti, :through => :appunto_righe
  
  validates :data, :presence => true
  validates :numero, :presence => true
  
  scope :per_numero, order('fatture.numero desc')
  
  after_save :update_righe_status, :update_appunti_status
  #before_destroy :update_righe_status
  
  composed_of :importo,
      :class_name  => "Money",
      :mapping     => [%w(importo_fattura cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |importo_fattura, currency| Money.new(importo_fattura || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Impossibile convertire #{value.class}") }
  
  composed_of :iva,
      :class_name  => "Money",
      :mapping     => [%w(totale_iva cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |totale_iva, currency| Money.new(totale_iva || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Impossibile convertire #{value.class}") }
  
  TIPO_FATTURA = [ "Fattura", "Vendita" ]
  TIPO_PAGAMENTO = ["Contanti", "Assegno", "Bonifico Bancario", "Bollettino Postale"]
  
  def add_righe_from_scuola(scuola) 
    scuola.appunto_righe.da_fatturare.each do |riga|
      self.totale_copie += riga.quantita
      self.importo_fattura += riga.quantita * riga.prezzo_unitario
      self.appunto_righe << riga
    end
  end
  
  def add_righe_from_appunti(scuola, appunti)
    app = Appunto.find(appunti)
   
    app.each do |a|
      a.appunto_righe.da_fatturare.each do |riga|
        self.totale_copie += riga.quantita
        self.importo_fattura += riga.quantita * riga.prezzo_unitario
        self.appunto_righe << riga
      end
    end
  end
  
  def get_new_id(user)
    Fattura.where("user_id = ?", user.id).last == nil ? 1 : Fattura.where("user_id = ?", user.id).last[:numero] + 1  
  end
  
  def ricalcola
    self.totale_copie = self.appunto_righe.sum(:quantita)
    self.importo_fattura = self.appunto_righe.sum("appunto_righe.prezzo_unitario * appunto_righe.quantita")
    self.save
  end
  
  def sistema_minguzzi
    ming = Scuola.find(253)
    
    ming.appunto_righe.where("appunto_righe.appunto_id in (2316, 2434, 2441)").each do |a|
      a.update_attributes(:fattura_id => 8)
    end
    
    ming.appunto_righe.where("appunto_righe.appunto_id in (2481, 2501, 2543)").each do |a|
      a.update_attributes(:fattura_id => 9)
    end
    
    ming.appunto_righe.where("appunto_righe.appunto_id in (2594)").each do |a|
      a.update_attributes(:fattura_id => 10)
    end

    ming.fatture.all.each do |f|
      f.ricalcola
    end
    
    p "done!"
  end
  
  private
  
    def update_righe_status
      # appunto_righe.each do |riga|
      #   riga.update_attributes({:pagato => self.pagata, :consegnato => true})
      # end
    end
    
    def update_appunti_status
      if pagata?
        appunti.each do |a|
          a.update_attributes({:stato => "X"})
        end
      end
    end
end
