# == Schema Information
# Schema version: 20110113205851
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
#  scuola_id    :integer(4)
#  position     :integer(4)
#  email        :string(255)
#  user_id      :integer(4)
#

class Appunto < ActiveRecord::Base
  
  acts_as_list
  
  belongs_to :scuola
  belongs_to :user
  
  default_scope :order => "appunti.updated_at DESC, appunti.id DESC" 
  
  scope :in_sospeso, where("appunti.stato = ?", "P")
  scope :in_corso, where("appunti.stato != ? or appunti.stato is null", "X")
  
  #vecchio stile
  #scope :instance_appunti, lambda { |user| where("appunti.user_id = ?", user.id) }
  
  # def self.search(params)  
  #   
  #   appunti = scoped
  #   if params[:search] 
  #     appunti = appunti.joins(:scuola)
  #     appunti = appunti.where('appunti.destinatario LIKE ? OR scuole.nome_scuola LIKE ?', "%" + params[:search] + "%", "%" + params[:search] + "%")
  #   end
  # 
  #   appunti
  # end  
  
  def self.provincia(params)
    
    appunti = scoped
    if params[:provincia]
      appunti = appunti.joins(:scuola).where(:scuola => { :provincia => params[:provincia]})
    end
    
    appunti
  end


  def scuola_nome_scuola_completo
    [scuola.nome_scuola, '('+scuola.citta.capitalize+')'].join(" ") if scuola
  end

  def scuola_nome_scuola
    scuola.nome_scuola if scuola
  end  
  
  def scuola_nome_scuola=(nome)
    self.scuola = Scuola.find_by_nome_scuola(nome)
  end
  
end
