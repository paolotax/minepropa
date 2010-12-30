class RenameColumnsScuole < ActiveRecord::Migration
  def self.up
    rename_column :scuole, :nome, :nome_scuola
  end

  def self.down
    rename_column :scuole, :nome_scuola, :nome
  end
end
