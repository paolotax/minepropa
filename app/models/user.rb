# == Schema Information
# Schema version: 20110228203907
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  username             :string(255)
#  phone                :string(255)
#  name                 :string(255)
#

class User < ActiveRecord::Base
  
  has_many :scuole,  :dependent => :destroy
  has_many :appunti, :dependent => :destroy
  has_many :visite,  :dependent => :destroy
  has_many :fatture, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, :phone, :codice_fiscale, :partita_iva
  
  def to_s
    self.username
  end
  
  def get_provincie
    scuole.select('distinct provincia').order('provincia')
  end
  
  def citta_con_appunti_in_corso(provincia)
    
      unless provincia.nil?
      appunti.
      joins(:scuola).where("scuole.provincia = ?", provincia).
      da_fare.
      joins(:scuola).
      select("scuole.provincia, scuole.citta, count(appunti.id) as count_appunti_in_corso").
      group("scuole.provincia, scuole.citta").
      order("scuole.provincia, scuole.citta").
      all.
      group_by(&:provincia)
    else
      appunti.
      da_fare.
      joins(:scuola).
      select("scuole.provincia, scuole.citta, count(appunti.id) as count_appunti_in_corso").
      group("scuole.provincia, scuole.citta").
      order("scuole.provincia, scuole.citta").
      all.
      group_by(&:provincia)
    end
  end
  
  
end
