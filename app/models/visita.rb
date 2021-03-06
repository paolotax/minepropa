# == Schema Information
# Schema version: 20110319153740
#
# Table name: visite
#
#  id             :integer         not null, primary key
#  visitable_id   :integer
#  visitable_type :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  title          :string(255)
#  start          :datetime
#  end            :datetime
#  all_day        :boolean
#

class Visita < ActiveRecord::Base
  
  belongs_to :visitable, :polymorphic => true
  belongs_to :user
  
end
