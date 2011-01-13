class AddUserIdToScuole < ActiveRecord::Migration
  def self.up
    add_column :scuole, :user_id, :integer
  end

  def self.down
    remove_column :scuole, :user_id
  end
end
