class AddTypeToLibri < ActiveRecord::Migration
  def self.up
    add_column :libri, :type, :string
    rename_column :libri, :categoria_id, :materia_id
    
  end

  def self.down
    remove_column :libri, :type
    rename_column :libri, :materia_id, :categoria_id
  end
end
