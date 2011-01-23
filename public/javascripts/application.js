// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('.auto_search_complete').autocomplete({
    minLength: 2,
    delay: 600,
    source: function(request, response) {
        $.ajax({
            url: "/autocomplete.js",
            dataType: "json",
            data: {term: request.term},
            success: function( data ) {
                response( data );
            }
        });
    }           
});

if (history && history.pushState) {
	$(function () {  
 	 	// Sorting and pagination links.  
	 	$("#appunti .pagination a").live("click", function() {
	   		$.getScript(this.href);
	        history.pushState(null, document.title, this.href);
	        //  e.preventDefault();
			return false;
	 	});
	 	
		$('#search_appunti').submit(function () {  
			$.get(this.action, $("#search_appunti").serialize(), null, 'script');  
			history.pushState(null, document.title, $("#search_appunti").attr("action") + "?" + $("#search_appunti").serialize()); 
	 	    return false;
		});
	
		$(window).bind("popstate", function() {
			 $.getScript(location.href);
		});

	
	 // ricerca con keyup
	 // $("#search_appunti input").keyup(function() {
	 //   $.get($("#search_appunti").attr("action"), $("#search").serialize(), null, "script");
	 //   return false;
	 // });

	});
}

