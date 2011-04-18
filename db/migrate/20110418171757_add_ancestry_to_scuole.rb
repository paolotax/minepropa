class AddAncestryToScuole < ActiveRecord::Migration
  def self.up
    add_column :scuole, :ancestry, :string
    add_index  :scuole, :ancestry
  end

  def self.down
    remove_column :scuole, :ancestry
    remove_index  :scuole, :ancestry
  end
end
