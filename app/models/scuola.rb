# == Schema Information
# Schema version: 20110705104946
#
# Table name: scuole
#
#  id             :integer         not null, primary key
#  nome_scuola    :string(255)
#  citta          :string(255)
#  provincia      :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  position       :integer
#  user_id        :integer
#  ancestry       :string(255)
#  telefono       :string(255)
#  fax            :string(255)
#  cellulare      :string(255)
#  email          :string(255)
#  partita_iva    :string(255)
#  codice_fiscale :string(255)
#

class Scuola < ActiveRecord::Base
  
  acts_as_list
  has_ancestry
  
  belongs_to :user
  has_many :appunti,     :dependent => :destroy
  has_many :fatture,     :dependent => :destroy
  has_many :classi,      :dependent => :destroy
  has_many :adozioni, :through => :classi, :include => :libro
  has_many :mie_adozioni, :through => :classi, :source => :adozioni, :include => :libro, :conditions => "libri.type = 'Scolastico'"
  
  
  has_many :visite,    :as => :visitable,    :dependent => :destroy 
  has_many :indirizzi, :as => :indirizzable, :dependent => :destroy
  
  has_many :tappe
  has_many :giri, :through => :tappe
  
  #attr_accessible :nome_scuola, :citta, :provincia, :position
  
  accepts_nested_attributes_for :indirizzi, :allow_destroy => true 
  
  validates :user_id,      :presence => true
  validates :nome_scuola,  :presence => true,
                           :uniqueness => { :scope => :user_id, :message => "gia' utilizzato!" }
  validates :citta,        :presence => true
  validates :provincia,    :presence => true, :length => { :is => 2 }
  
  before_save :clean_up
  

  scope :direzioni,  where(:nome_scuola.matches % "IC %" | :nome_scuola.matches % "D %")
  scope :elementari, where(:nome_scuola.matches % "E %")
  scope :cartolerie, where(:nome_scuola.matches % "C %")
  scope :dell_utente,   lambda { |user| where('scuole.user_id = ?', user) }
  scope :per_provincia, lambda { |prov| where('scuole.provincia = ?', prov) }
  
  scope :per_id, order(:id)
  
  scope :con_appunti_in_corso, lambda {
                                  select('scuole.*, count(appunti.id) as count_appunti_id').
                                  joins(:appunti).
                                  group(Scuola.column_names.map { |x| "scuole.#{x}" }.join(', ')) & Appunto.in_corso
                               }
  
  # scope :con_adozioni, lambda {
  #                                 select('scuole.*, count(adozioni.id) as count_adozioni_id').
  #                                 joins(:adozioni).
  #                                 group(Scuola.column_names.map { |x| "scuole.#{x}" }.join(', ')) & Adozione.scolastico
  #                              }
  
  scope :con_adozioni, includes(:adozioni).where('adozioni.id is not null') & Adozione.scolastico
  
  scope :da_visitare, includes(:giri).where('giri.id is null')

  # default_scope :order => "scuole.position ASC"
  
  def to_s
    "#{nome_scuola} #{citta} #{provincia}"
  end
  
  def nome_scuola_completo
     [nome_scuola, citta].join(" ")
  end  

  def self.search_for_nome(q)
    [:nome_scuola].inject(scoped) do |combined_scope, attr|        #tolto :citta dall array per AND
       combined_scope.where("scuole.#{attr} LIKE ?", "%#{q}%")
    end
  end

  def lat_long
    indirizzo = self.indirizzi.first
    return indirizzo.latitude.to_s+','+indirizzo.longitude.to_s unless indirizzo.nil?
  end

  def get_adozioni_per_libro
    adozioni = Adozione.
                  joins(:classe, :libro).
                  select('classi.scuola_id, classi.classe as cl, adozioni.materia_id, adozioni.libro_id, libri.titolo, libri.type').
                  select('sum(adozioni.nr_sezioni) as totale_sezioni, sum(adozioni.nr_copie) as totale_copie').
                  select('array_agg(classi.sezione) as sezioni').
                  select('array_agg(adozioni.id)    as adozioni_ids').
                  where("classi.scuola_id = ?", self.id).
                  group('classi.scuola_id, classi.classe, adozioni.materia_id, adozioni.libro_id, libri.titolo, libri.type')
    
    adozioni.each { |a| a.sezioni = a.sezioni.gsub(/[{}]/, '').split(',').sort.join }
    #adozioni.sort { |a,b| a.cl <=> b.cl && a.materia_id <=> b.materia_id && a.sezioni <=> b.sezioni }    
    adozioni.sort { |a,b| [a.cl, a.materia_id, a.sezioni] <=> [b.cl, b.materia_id, b.sezioni] }
  end  
  
  def get_adozioni
    adozioni = self.adozioni.
                    includes(:libro, :classe, :materia).
                    order('classi.classe, adozioni.materia_id, classi.sezione, libri.id').
                    group_by {|c| { :classe => c.classe.classe, :materia => c.materia.materia, :titolo => c.libro.titolo, :type => c.libro.type }}
  end
  
  def get_classi
    classi = self.classi.
                    order('classi.classe, classi.sezione').
                    group_by(&:classe)
  end
  
  private
  
    def clean_up
      self[:nome_scuola] = self[:nome_scuola].upcase
      self[:provincia]   = self[:provincia].upcase
      self[:citta]       = self[:citta].titleize
    end
  
end
