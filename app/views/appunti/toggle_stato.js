var current_appunto = $('#appunto_<%= h(@appunto.id) %>_visita_');

if ($(".appunto_righe_list", current_appunto).length > 0) {
	current_appunto.replaceWith("<%= escape_javascript(render @appunto, :app_righe => true ) %>" );
} else {
	current_appunto.replaceWith("<%= escape_javascript(render @appunto, :app_righe => false ) %>" );
}


//
//  Vecchio sistemas
// var current_appunto = $('#appunto_<%= h(@appunto.id) %>_visita_');
// current_appunto.removeClass('done pending active');
// current_appunto.addClass('<%= get_status_class(@appunto.stato) %>');

