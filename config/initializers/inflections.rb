# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
   inflect.plural /^(ox)$/i, '\1en'
   inflect.singular /^(ox)en/i, '\1'
   inflect.irregular 'person', 'people'
   inflect.irregular 'appunto', 'appunti'
   inflect.irregular 'scuola', 'scuole'
   inflect.irregular 'visita', 'visite'   
   inflect.irregular 'indirizzo', 'indirizzi'
   inflect.irregular 'libro', 'libri'
   inflect.irregular 'librino', 'librini'
   inflect.irregular 'riga', 'righe'
   inflect.irregular 'fattura', 'fatture'
   inflect.irregular 'insegnante', 'insegnanti'
   inflect.irregular 'classe', 'classi'
   inflect.irregular 'adozione', 'adozioni'
   inflect.irregular 'materia', 'materie'
   inflect.uncountable %w( fish sheep )
end
