class AddUserIdToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :user_id, :integer
  end

  def self.down
    remove_column :appunti, :user_id
  end
end
