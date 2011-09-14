require 'spec_helper'

describe Visita do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
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

