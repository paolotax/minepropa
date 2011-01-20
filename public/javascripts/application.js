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

// $(function () {  
//   // Sorting and pagination links.  
//   
//   
// 
// 
//     
//   // Search form.  
// 	//   $('#search_appunti').submit(function () {  
// 	//     console.log('searc')
// 	// $.get(this.action, $(this).serialize(), null, 'script');  
// 	// return false;  
// 	//   });  
// });


