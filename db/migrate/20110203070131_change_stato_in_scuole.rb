class ChangeStatoInScuole < ActiveRecord::Migration
  def self.up
    change_column :appunti, :stato, :string, :default => "", :null => false
  end

  def self.down
    change_column :appunti, :stato, :string
  end
end
