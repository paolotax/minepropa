class AddVisiteEnd < ActiveRecord::Migration
  def self.up
    add_column :visite, :end, :datetime
    remove_column :visite, :ora_inizio
    remove_column :visite, :ora_fine
    remove_column :visite, :note
    remove_column :visite, :data
  end

  def self.down
    remove_column :visite, :end
    add_column :visite, :ora_inizio, :time
    add_column :visite, :ora_fine,   :time
    add_column :visite, :note,       :string
    add_column :visite, :data,       :date
  end
end
