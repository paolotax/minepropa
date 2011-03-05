# == Schema Information
# Schema version: 20110228203907
#
# Table name: visite
#
#  id             :integer         not null, primary key
#  data           :date
#  ora_inizio     :time
#  ora_fine       :time
#  note           :string(255)
#  visitable_id   :integer
#  visitable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Visita < ActiveRecord::Base
  
  belongs_to :visitable, :polymorphic => true
  belongs_to :user
  
end
