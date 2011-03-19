class ChangeVisite < ActiveRecord::Migration
  def self.up
    remove_column :visite, :start
    remove_column :visite, :end
    add_column :visite, :start, :timestamp
    add_column :visite, :end,   :timestamp
    add_column :visite, :all_day, :boolean
  end

  def self.down
    remove_column :visite, :start
    remove_column :visite, :end
    remove_column :visite, :all_day

    add_column :visite, :start, :datetime
    add_column :visite, :end,   :datetime
  end
end
