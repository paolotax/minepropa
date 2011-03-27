$("#da_draggare").html("<%= escape_javascript(render("appunti/appunti")) %>");
$('#da_draggare div.appunto_big').addTouch();