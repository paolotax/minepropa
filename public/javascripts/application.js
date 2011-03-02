/* Copyright (c) 2009 Mustafa OZCAN (http://www.mustafaozcan.net)
* Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
* and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
* Version: 1.0
* Requires: jquery.1.2.6+
*/
(function($) { $.fn.bestupper = function(settings) { var defaults = { ln: 'en', clear: true }, settings = $.extend({}, defaults, settings); this.each(function() { var $this = $(this); if ($this.is('textarea') || $this.is('input:text')) { $this.keypress(function(e) { var pressedKey = e.charCode == undefined ? e.keyCode : e.charCode; var str = String.fromCharCode(pressedKey); if (pressedKey < 97 || pressedKey > 122) { if (settings.ln == 'en' || !isTRChar(pressedKey)) return; } if (settings.ln == 'tr' && pressedKey == 105) str = '\u0130'; if (this.createTextRange) { window.event.keyCode = str.toUpperCase().charCodeAt(0); return; } else { var startpos = this.selectionStart; var endpos = this.selectionEnd; this.value = this.value.substr(0, startpos) + str.toUpperCase() + this.value.substr(endpos); this.setSelectionRange(startpos + 1, startpos + 1); return false; } }); if (settings.clear) { $this.blur(function(e) { if (settings.ln == 'tr') this.value = this.value.replace(/i/g, "\u0130"); this.value = this.value.replace(/^\s+|\s+$/g, "").replace(/\s{2,}/g, " ").toUpperCase(); }); } } }); }; function isTRChar(key) { var trchar = [231, 246, 252, 287, 305, 351]; for (var i = 0; i < trchar.length; i++) { if (trchar[i] == key) return true; } return false; } })(jQuery);


$(document).ready(function(){
 $("#provincie li").hover(
   function(){ $("ul", this).fadeIn("fast"); }, 
   function() { } 
 );
 if (document.all) {
   $("#provincie li").hoverClass ("sfHover");
 }
});

$(document).ready(function(){

});


$.fn.hoverClass = function(c) {
 return this.each(function(){
   $(this).hover( 
     function() { $(this).addClass(c);  },
     function() { $(this).removeClass(c); }
   );
 });
};



jQuery(function() {
 $('.auto_search_complete').autocomplete({
     minLength: 2,
     delay: 600,
     source: function(request, response) {
         $.ajax({
             url: "/autocomplete_searches.js",
             dataType: "json",
             data: {term: request.term},
             success: function( data ) {
                 response( data );
             }
         });
     }           
 });
 
 $("#provincie li").hover(function(){$(this).effect("highlight", {}, 1000);});
 
});

if (history && history.pushState) {
	
  $(document).ready(function () {  
    
    $(window).scroll(function() {
    $('#sidebar')
        .stop()
        .animate({top: $(document).scrollTop()},'slow','easeOutBack');
    });

		$('#appunto_nome_scuola').bestupper(); 
 	 	
 	 	// Sorting and pagination links.  
    // $("#appunti .pagination a,  #provincie a").live("click", function() {
    //        $.getScript(this.href);
    //          history.pushState(null, document.title, this.href);
    //          // event.preventDefault();
    //      return false;
    // });
	    
    $("#status_image a").live("click", function() {
         alert('ciao');
         $.getScript(this.href);
         return false;
    });
	 	
		$('#appunto_search').submit(function () {  
			$.get(this.action, $("#appunto_search").serialize(), null, 'script');  
			history.pushState(null, document.title, $("#appunto_search").attr("action") + "?" + $("#appunto_search").serialize()); 
	 	    return false;
		});
		
		$('#scuola_search').submit(function () {  
			$.get(this.action, $("#scuola_search").serialize(), null, 'script');  
			history.pushState(null, document.title, $("#scuola_search").attr("action") + "?" + $("#scuola_search").serialize()); 
	 	    return false;
		});
		
		$('#scuole_sort_list').sortable({
  		axis: 'y',
  		dropOnEmpty: false,
  		handle: '.handle',
  		cursor: 'crosshair',
  		items: 'li',
  		opacity: 0.4,
  		scroll: true,
  		update: function(){
  			$.ajax({
  				type: 'post',
  				data: $('#scuole_sort_list').sortable('serialize'),
  				dataType: 'script', 
  				complete: function(request){
  					$('#scuole_sort_list').effect('highlight');
  				},
          url: '/scuole/sort'
        })
  		}
    });    
		
		
		$( "#da_assegnare" ).sortable({
  			connectWith: ".connectedSortable",
  			opacity: 0.7,
    		scroll: true,
        remove: function(event, ui) {          
          var x = ui.item.attr('id').split('_');          
          $.ajax({
            type: 'post',
            // data: 'id=' + ui.item.attr('id') + '&db=' + ui.item.attr('offsetParent').id,
            url: '/appunti/' + x[1] + '/visite',
            success: function() {
	            $("#assegnati_size").html(parseInt($("#assegnati_size").html()) +1);
              $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);
            }
          })
        }
		}).disableSelection();
		
		$( "#assegnati" ).sortable({
  			connectWith: ".connectedSortable",
  			opacity: 0.7,
    		scroll: true,
        remove: function(event, ui) {          
          var x = ui.item.attr('id').split('_');
          $.ajax({
            type: 'delete',
            // data: 'id=' + ui.item.attr('id') + '&db=' + ui.item.attr('offsetParent').id,
            url: '/appunti/' + x[1] + '/visite/' + x[3],
            success: function() {
	            $("#assegnati_size").html(parseInt($("#assegnati_size").html()) -1);
              $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) + 1);
            }
          })
        }
		}).disableSelection();


		
    // $(function() {
    //      $(".block").draggable();
    //      $("#droppable").droppable({
    //        drop: function(event, ui) {
    //          $(this).addClass('ui-state-highlight').find('p').html('Rilasciato!');
    //        }
    //      });
    //     });
		
	 // ricerca con keyup
	 // $("#search_appunti input").keyup(function() {
	 //   $.get($("#search_appunti").attr("action"), $("#search").serialize(), null, "script");
	 //   return false;
	 // });

	});
}

function historySupport() {
  return !!(window.history && window.history.pushState !== undefined);
}

function pushPageState(state, title, href) {
  if (historySupport()) {
    history.pushState(state, title, href);
  }
}

function replacePageState(state, title, href) {
  if (state == undefined) { state = null; }
  
  if (historySupport()) {
    history.replaceState(state, title, href);
  }
}

$(function() {
  window.onpopstate = function(e) {
    if ($('body').attr('data-state-href') === location.href) {
      return false;
    }
    
    if (e.state !== null) {
      // do something with your state object
    }
    
    $.ajax({
      url: location.href,
      dataType: 'script',
      success: function(data, status, xhr) {
        $('body').trigger('ajax:success');
      },
      error: function(xhr, status, error) {
        // You may want to do something else depending on the stored state
        alert('Failed to load ' + location.href);
      },
      complete: function(xhr, status) {
        $('body').attr('data-state-href', location.href);
      }
    });
  };
  
  
  var getA = 'a[data-remote][data-method!="put"][data-method!="post"][data-method!="delete"]'
    , getForm = 'form[data-remote][method="get"]';
  
  function getState(el) {
    // insert your own code here to extract a relevant state object from an <a> or <form> tag
    // for example, if you rely on any other custom "data-" attributes to determine the link behaviour
    return {};
  };
  
  $('body').attr('data-state-href', location.href);
  
  $(getA).
    live('ajax:beforeSend', function(xhr) {
      pushPageState(getState(this), "Loading...", this.href);
      window.title = "Loading...";
    });

  $(getForm).
    live('ajax:beforeSend', function(xhr) {
      var href = $(this).attr("action") + "?" + $(this).serialize();
      
      pushPageState(getState(this), 'Loading...', href);
      window.title = "Loading...";
    });
    
  $(getA + ',' + getForm).
    live('ajax:complete', function(xhr) {
      $('body').attr('data-state-href', location.href);
      replacePageState(getState(this), window.title, location.href);
    });
});
