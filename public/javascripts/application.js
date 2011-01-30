$(document).ready(function(){
	$("#provincie li").hover(
		function(){ $("ul", this).fadeIn("fast"); }, 
		function() { } 
	);
	if (document.all) {
		$("#provincie li").hoverClass ("sfHover");
	}
});

$.fn.hoverClass = function(c) {
	return this.each(function(){
		$(this).hover( 
			function() { $(this).addClass(c);  },
			function() { $(this).removeClass(c); }
		);
	});
};




// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
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
				url: '/scuole/sort'})
		}
	});
});

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
	$(function () {  
 	 	// Sorting and pagination links.  
	 	$("#appunti .pagination a,  #provincie a").live("click", function() {
	   		$.getScript(this.href);
	        history.pushState(null, document.title, this.href);
	        // event.preventDefault();
			return false;
	 	});
	    
	    $("#status_image a").live("click", function() {
	   		$.getScript(this.href);
			return false;
	 	});
	 	
		$('#search_appunti').submit(function () {  
			$.get(this.action, $("#search_appunti").serialize(), null, 'script');  
			history.pushState(null, document.title, $("#search_appunti").attr("action") + "?" + $("#search_appunti").serialize()); 
	 	    return false;
		});
		
		
		
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
