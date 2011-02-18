$('.appunto_<%= @visitable.id %>').slideUp('normal', this.remove);

var new_item = $('<%= escape_javascript(render :partial => "appunti/appunto", :object => @visitable) %>').hide();
$("#da_assegnare").append(new_item)
new_item.slideDown('normal');


