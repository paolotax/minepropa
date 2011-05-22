class AddCurrencyToLibri < ActiveRecord::Migration
  def self.up
    add_column :libri, :currency, :string
  end

  def self.down
    remove_column :libri, :currency
  end
end
