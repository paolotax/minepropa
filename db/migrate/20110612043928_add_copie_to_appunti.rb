class AddCopieToAppunti < ActiveRecord::Migration
  def self.up
    add_column :appunti, :appunto_righe_sum, :integer, :default => 0
  end

  def self.down
    remove_column :appunti, :appunto_righe_sum
  end
end
