class AddCoefficenteToLibro < ActiveRecord::Migration
  def self.up
    add_column :libri, :coefficente, :float
    add_column :libri, :cm, :string
  end

  def self.down
    remove_column :libri, :coefficente
    remove_column :libri, :cm
  end
end
