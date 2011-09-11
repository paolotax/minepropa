class AddAdozioniCounter < ActiveRecord::Migration
  def self.up
    add_column :scuole, :mie_adozioni_counter, :integer, :default => 0
    add_column :scuole, :appunti_in_corso_counter, :integer, :default => 0
    
    Scuola.reset_column_information

     Scuola.all.each do |e|
       Scuola.update_counters e.id, :mie_adozioni_counter => e.mie_adozioni.length
       Scuola.update_counters e.id, :appunti_in_corso_counter => e.appunti.in_corso.length
     end
  end

  def self.down
    remove_column :scuole, :mie_adozioni_counter
    remove_column :scuole, :appunti_in_corso_counter
  end
end
