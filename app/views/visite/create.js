$('.appunto_<%= @visitable.id %>').slideUp('normal', this.remove);
var new_item = $("<%= escape_javascript(render(@visitable)) %>").hide();
$(".right_appunti").prepend(new_item)
new_item.slideDown('normal');

