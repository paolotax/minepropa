# == Schema Information
# Schema version: 20110523180743
#
# Table name: appunto_righe
#
#  id              :integer         not null, primary key
#  libro_id        :integer
#  appunto_id      :integer
#  quantita        :integer
#  prezzo          :decimal(8, 2)
#  consegnato      :boolean
#  pagato          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  prezzo_unitario :integer
#  currency        :string(255)
#  sconto          :decimal(8, 2)
#

class AppuntoRiga < ActiveRecord::Base
  
  belongs_to :libro
  belongs_to :appunto
  
  delegate :titolo, :copertina, :consigliato, :prezzo_copertina, :prezzo_consigliato, :to => :libro
  
  
  #default_scope order("appunto_righe.id desc")
  
  scope :da_consegnare, where("appunto_righe.consegnato = false OR appunto_righe.consegnato IS NULL")
  scope :consegnati,    where("appunto_righe.consegnato = true")
  scope :pagati,        where("appunto_righe.pagato = true")
  scope :da_pagare,     where("appunto_righe.pagato = false OR appunto_righe.pagato IS NULL")
  
  scope :per_id,       order("appunto_righe.id desc")
  scope :per_libro_id, order("appunto_righe.libro_id")
  
  
  
  composed_of :unitario,
      :class_name  => "Money",
      :mapping     => [%w(prezzo_unitario cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |prezzo_unitario, currency| Money.new(prezzo_unitario || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
        
  def valore
    libro.copertina * quantita unless libro.nil?
  end
  
  # def titolo
  #   "#{libro.titolo}" unless libro.nil?
  # end
  
  def price
    unitario.to_s
  end
  
  def price=(pr)
    re = /([c|o])|([\d,]+)|(-[\d,]+)/
    m = re.match pr
    if m[1] == 'c'
      self.prezzo_unitario = self.prezzo_consigliato
    else
      if m[1] == 'o'
        self.unitario = "0"
      else
        if m[2] == pr
          self.unitario = pr
        else
          if m[3] == pr
            self.unitario = (self.prezzo_copertina - (self.prezzo_copertina * pr.split('-').last.to_f / 100)) / 100
          else
            m
          end
        end
      end
    end
  end
  
  def copertina
    libro.copertina unless libro.nil?
  end
  
  def prezzo_consigliato
    self.libro.prezzo_consigliato unless libro.nil?
  end
  
  def importo
    if unitario.blank?
      if sconto.blank?
        libro.copertina * quantita
      else
        (libro.copertina - ( libro.copertina / 100 * sconto )) * quantita
      end
    else
      unitario * quantita
    end  
  end

end
