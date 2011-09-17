# == Schema Information
# Schema version: 20110808105615
#
# Table name: libri
#
#  id                 :integer         not null, primary key
#  titolo             :string(255)
#  materia_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#  sigla              :string(255)
#  prezzo_copertina   :integer
#  prezzo_consigliato :integer
#  currency           :string(255)
#  coefficente        :float
#  cm                 :string(255)
#  type               :string(255)
#

class Libro < ActiveRecord::Base
  
  has_many :appunto_righe, :include => [:libro, {:appunto => [:scuola]}]
  has_many :adozioni
  
  #default_scope order("libri.id")  
  scope :per_classe_e_materia, lambda {
                                  |cl,mat| joins(:adozioni => :classe).
                                           select('distinct libri.*').
                                           where('classi.classe = ?', cl).
                                           where('adozioni.materia_id = ?', mat)
                               }
  scope :per_titolo, unscoped.order(:titolo)
  scope :vendibili, where("libri.type <> 'Concorrenza'").where("libri.type <> 'Scorrimento'")
  
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
      
  
  #fratelli usato per option group
  def bros
    Libro.unscoped.where("type = ?", self.type).order(:titolo)
  end
      
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Libro.model_name
      end
    end
    super
  end
  
  def self.select_options
    if Rails.env == 'development'
      ParascolasticoLibro.new
      VacanzeLibro.new
    end
    subclasses.map{ |c| c.to_s }.sort
  end
  
  def type_helper
    self.type
  end
  def type_helper=(type)
    self.type = type
  end
  
  @child_classes = []

  # def self.inherited(child)
  #   @child_classes << child
  #   super # important!
  # end
  # 
  # def self.child_classes
  #   @child_classes
  # end
  
    
  def copie_da_consegnare(user)
    self.appunto_righe.per_utente(user).da_consegnare.sum(:quantita)
  end
  
  def copie_vendute(user)
    self.appunto_righe.per_utente(user).sum(:quantita)
    # self.appunto_righe.sum(:quantita) || self.copie_vendute
  end
  
  def copie_consegnate(user)
    copie_vendute(user) - copie_da_consegnare(user) || copie_consegnate
  end
  
  def fatturato(user)
    self.appunto_righe.per_utente(user).sum("appunto_righe.prezzo_unitario * appunto_righe.quantita").to_f / 100
  end
end
