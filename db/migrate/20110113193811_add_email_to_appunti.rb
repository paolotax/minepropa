class AddEmailToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :email, :string
  end

  def self.down
    remove_column :appunti, :email
  end
end
