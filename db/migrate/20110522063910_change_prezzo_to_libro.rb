class ChangePrezzoToLibro < ActiveRecord::Migration
  def self.up
    add_column :libri, :prezzo_copertina, :integer
  end

  def self.down
    remove_column :libri, :prezzo_copertina  
  end
end
