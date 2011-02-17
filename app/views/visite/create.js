/* Add the new comment to the bottom of the comments list */
$('.appunto_<%= @visitable.id %>').slideUp();
$(".right_appunti").append("<%= escape_javascript(render(@visitable)) %>");

