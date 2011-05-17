# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Libro.delete_all
Libro.create(:titolo => "CASTELLI DI SABBIA 1", :copertina => 7.00)
Libro.create(:titolo => "CASTELLI DI SABBIA 2", :copertina => 7.00)
Libro.create(:titolo => "CASTELLI DI SABBIA 3", :copertina => 7.00)
Libro.create(:titolo => "CASTELLI DI SABBIA 4", :copertina => 7.00)
Libro.create(:titolo => "CASTELLI DI SABBIA 5", :copertina => 7.00)

Libro.create(:titolo => "TUTTO VACANZE ITA 1", :copertina => 3.90)
Libro.create(:titolo => "TUTTO VACANZE MAT 1", :copertina => 3.90)

Libro.create(:titolo => "TUTTO VACANZE ITA 2", :copertina => 3.90)
Libro.create(:titolo => "TUTTO VACANZE MAT 2", :copertina => 3.90)

Libro.create(:titolo => "TUTTO VACANZE ITA 3", :copertina => 3.90)
Libro.create(:titolo => "TUTTO VACANZE MAT 3", :copertina => 3.90)

Libro.create(:titolo => "TUTTO VACANZE ITA 4", :copertina => 3.90)
Libro.create(:titolo => "TUTTO VACANZE MAT 4", :copertina => 3.90)

Libro.create(:titolo => "TUTTO NELLO ZAINO", :copertina => 6.90)


