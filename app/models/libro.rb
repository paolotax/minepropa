# == Schema Information
# Schema version: 20110522075657
#
# Table name: libri
#
#  id               :integer         not null, primary key
#  titolo           :string(255)
#  copertina        :decimal(8, 2)
#  categoria_id     :integer
#  created_at       :datetime
#  updated_at       :datetime
#  sigla            :string(255)
#  consigliato      :decimal(8, 2)
#  prezzo_copertina :integer
#  currency         :string(255)
#

class Libro < ActiveRecord::Base
  has_many :appunto_righe
  
  composed_of :copertina,
      :class_name  => "Money",
      :mapping     => [%w(prezzo_copertina cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |prezzo_copertina, currency| Money.new(prezzo_copertina || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
  composed_of :consigliato,
      :class_name  => "Money",
      :mapping     => [%w(prezzo_consigliato cents), %w(currency currency_as_string)],
      :constructor => Proc.new { |prezzo_consigliato, currency| Money.new(prezzo_consigliato || 0, currency || Money.default_currency) },
      :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
  
end
