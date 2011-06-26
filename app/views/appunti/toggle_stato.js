$('#appunto_<%= h(@appunto.id) %>_visita_').removeClass('done pending active');
$('#appunto_<%= h(@appunto.id) %>_visita_').addClass('<%= get_status_class(@appunto.stato) %>');


// Vecchio sistema con icone
// 
// $('.img_appunto_<%= h(@appunto.id) %>').html('<%= link_to image_tag(show_status_icon(@appunto.stato)), toggle_stato_appunto_path(@appunto) %>');
// $(".ts_appunto_<%= h(@appunto.id) %>").html('<small><%= get_posted_string(@appunto) %></small>');