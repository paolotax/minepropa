$('.appunto_<%= @visitable.id %>').slideUp('normal', this.remove);
var new_item = $("<%= escape_javascript(render(@visitable)) %>").hide();
$("#assegnati").prepend(new_item)
new_item.slideDown('normal');

$("#assegnati_size").html(parseInt($("#assegnati_size").html()) + 1);
$("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);

