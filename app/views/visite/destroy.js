var old_item = $('.appunto_<%= @visitable.id %>')
old_item.slideUp('normal');
old_item.remove;

var new_item = $('<%= escape_javascript(render :partial => "appunti/appunto", :object => @visitable) %>').hide();
$("#da_assegnare").prepend(new_item)
new_item.slideDown('normal');


