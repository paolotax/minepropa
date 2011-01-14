# == Schema Information
# Schema version: 20110109185008
#
# Table name: appunti
#
#  id           :integer(4)      not null, primary key
#  destinatario :string(255)
#  note         :text
#  telefono     :string(255)
#  stato        :string(255)
#  scadenza     :date
#  created_at   :datetime
#  updated_at   :datetime
#  scuola_id    :string(255)
#  position     :integer(4)
#

class Appunto < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  belongs_to :user
  
  default_scope :order => "appunti.updated_at DESC" 
  
  scope :in_sospeso, where("stato = ?", "P")
  scope :in_corso, where("stato != ? or stato is null", "X")
  scope :instance_appunti, lambda { |user| where("appunti.user_id = ?", user.id) }
  
  def self.search(params)  
    
    appunti = scoped
    if params[:search] 
      appunti = appunti.joins(:scuola)
      appunti = appunti.where('appunti.destinatario LIKE ? OR scuole.nome_scuola LIKE ?', "%" + params[:search] + "%", "%" + params[:search] + "%")
    end
    appunti = appunti.where("appunti.user_id = ?", params[:user_id]) if params[:user_id]
    appunti
  end  
  
  def scuola_nome_scuola_completo
    [scuola.nome_scuola, '('+scuola.citta.capitalize+')'].join(" ") if scuola
  end
  
  def scuola_nome_scuola_completo=(nome)
    self.scuola = Scuola.find_by_nome_scuola(nome)
  end
  
end
