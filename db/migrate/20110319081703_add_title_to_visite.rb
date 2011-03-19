class AddTitleToVisite < ActiveRecord::Migration
  def self.up
    add_column :visite, :start, :datetime
    add_column :visite, :title, :string
  end

  def self.down
    remove_column :visite, :start
    remove_column :visite, :title
  end
end
