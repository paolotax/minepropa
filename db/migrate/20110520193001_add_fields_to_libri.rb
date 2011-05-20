class AddFieldsToLibri < ActiveRecord::Migration
  def self.up
    add_column :libri, :sigla, :string
    add_column :libri, :consigliato, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :libri, :sigla
    remove_column :libri, :consigliato
  end
end
