class AggiustaPrezzi < ActiveRecord::Migration
  def self.up
    remove_column :libri, :copertina
    remove_column :libri, :consigliato
    remove_column :libri, :prezzo_copertina
    remove_column :libri, :currency
    
    add_column :libri, :prezzo_copertina,   :integer  # in cents
    add_column :libri, :prezzo_consigliato, :integer  # in cents
    add_column :libri, :currency, :string
    
    #  titolo           :string(255)
    #  copertina        :decimal(8, 2)
    #  categoria_id     :integer
    #  created_at       :datetime
    #  updated_at       :datetime
    #  sigla            :string(255)
    #  consigliato      :decimal(8, 2)
    #  prezzo_copertina :integer
    #  currency         :string(255)
    #
  end

  def self.down
    
    remove_column :libri, :prezzo_copertina
    remove_column :libri, :prezzo_consigliato
    remove_column :libri, :currency
    
    add_column :libri, :copertina,   :decimal, :precision => 8, :scale => 2 
    add_column :libri, :consigliato, :decimal, :precision => 8, :scale => 2 
    add_column :libri, :prezzo_copertina, :integer
    add_column :libri, :currency, :string
    
  end
end
