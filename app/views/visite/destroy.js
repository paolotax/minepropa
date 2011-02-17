$('.appunto_<%= @visitable.id %>').slideUp();
$(".left_appunti").append("<%= escape_javascript(render(@visitable)) %>");
