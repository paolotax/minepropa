$(document).ready( function() {
  
  // $( "#dialog-modal" ).dialog({
  //  height: 500,
  //  width: 700,
  //  modal: true
  // });
	
	
});


/* ----------------
    datepicker 
-----------------*/
$(document).ready(function($){
  
  /* Italian initialisation for the jQuery UI date picker plugin. */
  /* Written by Antonello Pasella (antonello.pasella@gmail.com). */
  
	$.datepicker.regional['it'] = {
		closeText: 'Chiudi',
		prevText: '&#x3c;Prec',
		nextText: 'Succ&#x3e;',
		currentText: 'Oggi',
		monthNames: ['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno',
			'Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'],
		monthNamesShort: ['Gen','Feb','Mar','Apr','Mag','Giu',
			'Lug','Ago','Set','Ott','Nov','Dic'],
		dayNames: ['Domenica','Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabato'],
		dayNamesShort: ['Dom','Lun','Mar','Mer','Gio','Ven','Sab'],
		dayNamesMin: ['Do','Lu','Ma','Me','Gi','Ve','Sa'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['it']);

  $( "#giorno_giro" ).datepicker({
    'dateFormat': "D, d MM yy"
  });

});


/* -----------------------
    select all checkbox 
------------------------*/
$(document).ready( function() {
  $( '.checkAll' ).live( 'change', function() {
      $( '.cb-element' ).attr( 'checked', $( this ).is( ':checked' ) ? 'checked' : '' );
      $( this ).next().text( $( this ).is( ':checked' ) ? 'Deseleziona Tutti' : 'Seleziona Tutti' );
  });
  $( '.invertSelection' ).live( 'click', function() {
      $( '.cb-element' ).each( function() {
          $( this ).attr( 'checked', $( this ).is( ':checked' ) ? '' : 'checked' );
      }).trigger( 'change' );

  });
  $( '.cb-element' ).live( 'change', function() {
      $( '.cb-element' ).length == $( '.cb-element:checked' ).length ? $( '.checkAll' ).attr( 'checked', 'checked' ).next().text( 'Deseleziona Tutti' ) : $( '.checkAll' ).attr( 'checked', '' ).next().text( 'Seleziona Tutti' );

  });
});


/* -----------------------
    edit multiple - pdf 
------------------------*/
$(document).ready(function() {

  $('#btn_pdf').live('click', function () {
    var params = $('#form_appunti').serialize();
    // console.log(params);
    $('#form_appunti').attr({'action': '/appunti/print_multiple', 'method': 'get'});
    $('#form_appunti').submit();
    // non funziona
    //     $('form').submit(function () {
    //       console.log(params);  
    //       $.get(this.action, params, null, 'script');  
    //       return false;
    // });
  });
  
  $('#btn_edit').live('click', function () {
     var params = $('#form_appunti').serialize();
     // console.log(params);
     $('#form_appunti').attr({'action': '/appunti/edit_multiple', 'method': 'post'});
     $('#form_appunti').submit();
  });
});


/* ---------------
    google maps 
----------------*/
$(document).ready(function() {
  
  function secondsToTime(secs)
  {
   var hours = Math.floor(secs / (60 * 60));

   var divisor_for_minutes = secs % (60 * 60);
   var minutes = Math.floor(divisor_for_minutes / 60);

   var divisor_for_seconds = divisor_for_minutes % 60;
   var seconds = Math.ceil(divisor_for_seconds);

   var obj = {
     "h": hours,
     "m": minutes,
     "s": seconds
   };
   return obj;
  };
  
  function calcRoute(ds, dd, my) {
    var start = 'Via Vestri 4, Bologna, it';
    var end =   'Via Zanardi 376/2, BOLOGNA, it';
    var waypts = [];
    
    console.log(start);
    for (var i = 0; i < my.length; i++) {
        waypts.push({
            location:my[i].latitude+','+my[i].longitude,
            stopover:true});
    }
              
    var request = {
        origin: start, 
        destination: end,
        waypoints: waypts,
        optimizeWaypoints: true,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    
    ds.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        dd.setDirections(response);
        var route = response.routes[0];
        var summaryPanel = document.getElementById("directions_panel");
        
        summaryPanel.innerHTML = "";
        var distance = 0;
        var duration = 0;
        // For each route, display summary information.
        for (var i = 0; i < route.legs.length; i++) {
          var routeSegment = i + 1;
          summaryPanel.innerHTML += "<b>Tappa: " + routeSegment + "</b>  ..." +  route.legs[i].distance.text + " " + route.legs[i].duration.text + "<br />";
          summaryPanel.innerHTML += route.legs[i].end_address + "<br /><br />";
          distance = distance + route.legs[i].distance.value;
          duration = duration + route.legs[i].duration.value;
          console.log(route.legs[i].distance.text);
        }
        console.log(distance);
        var tempo = secondsToTime(duration);
        console.log(tempo)
        $('#directions_panel').prepend('<div>distanza da percorrere: ' + (distance / 1000) + ' km circa. <br />tempo stimato: ' + tempo.h + 'h ' + tempo.m + 'min ' + tempo.s + 'sec. circa</div><br/>');  
      }
    });
  }
  
  $("#print_calendar").click(function(){
      $("#calendar").printArea();
  });
  
  $("#print_map").click(function(){
       $("#map_appunti").printArea();
  });
  
  $('#map').hide();
  $('#map_appunti').hide();
  
  var scu_id  = $.trim($('.scuola_id').text());
  var ind_id  = $.trim($('.scuola_indirizzo_id').text());
  var url = scu_id + ".json";
 

  /* 
   *   mappa scuola
   *
   */
  $('#map_show').click(function(){
    
    $("#map").toggle();
    
    if ($('#map').is(':visible')) {
      $('#map_show').find(":submit").attr('value', 'Nascondi Mappa');
      var mark = $.getJSON(url, function(myMarkers){
         
         $("#map").goMap({
             markers: myMarkers,
             zoom: 15,
             maptype:  'ROADMAP',
             directions: true,
             getDirections: true,
             streetViewControl: true
         });
         
         $('#map').show();
       
         $.goMap.createListener({type:'marker', marker:'baseMarker'}, 'dragend', function() { 
           var lat = this.getPosition().lat();
           var lng = this.getPosition().lng();
           $('.scuola_latlong').html(lat + ' ' + lng);
           $.ajax({
             type: 'put',
             data: '&longitude=' + lng + '&latitude=' + lat, 
             url: '/maps/' + ind_id + '/update_latlong/' 
           });
         });
      });
    } else {
      $('#map_show').find(":submit").attr('value', 'Mostra Mappa');
    }
  });


  /* 
   *   mappa appunti
   *
   */
  $('#map_show_appunti').click(function(){
    
    $( "#dialog-modal" ).dialog({
  		height: 600,
  		width:  800,
  		modal: true
  	});
  	
  	$('#map_appunti').show();
    var calendar = $('#calendar').fullCalendar('getDate');
    console.log(calendar);
    
    var mark = $.getJSON('/maps/get_appunti_markers.json', function(myMarkers){
       
      $("#map_appunti").goMap({
        markers: myMarkers,
        maptype: 'ROADMAP',
        streetViewControl: true
      });
      
      var m = $.goMap.getMap();
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(m);

      calcRoute(directionsService, directionsDisplay, myMarkers);
      $.goMap.fitBounds(); 
    });

    // $('#map_appunti').toggle();
    //       
    //     if ($('#map_appunti').is(':visible')) {
    //       var mark = $.getJSON('/maps/get_appunti_markers.json', function(myMarkers){
    //          
    //      ...       
    //             calcRoute(myMarkers);
    //             $.goMap.fitBounds(); 
    //       });
    //       $('#map_show_appunti').find(":submit").attr('value', 'Nascondi Mappa');
    //     } else {
    //       $('#map_show_appunti').find(":submit").attr('value', 'Mostra Mappa');
    //       $('#directions_panel').html("");
    //     }
    
  });
  
  
  $("#markers_add").click( function() {
     var mark = $.getJSON('/maps/get_appunti_markers.json', function(myMarkers){
       for( i = 0; i < myMarkers.length; i++)
       {
          $.goMap.createMarker(myMarkers[i]);
       };
       $.goMap.fitBounds(); 
     });
  });
  
  $("#markers_fit").live("click", function() {
     $.goMap.fitBounds();
  });  
  
  function setInfoPosition() {
		var baseMarkerPosition = $("#map").data("baseMarker").getPosition();
    console.log('fired');
	}  
});


/* -----------------
    fullcalendar 
------------------*/
$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	//non funziona dopo ajax live()??
	$('#da_draggare div.appunto_big').addTouch();
	
	$('#da_draggare div.appunto_big').live('mouseover',function(){
      
      var eventObject = {
			
  			title: $.trim($("#a_destinatario", this).text()) +' '+ $.trim($("#a_scuola", this).text()),
  			id: $(this).attr('id')
      
  		};

  		// store the Event Object in the DOM element so we can get to it later
  		$(this).data('eventObject', eventObject);

  		// make the event draggable using jQuery UI
  		$(this).draggable({
  			zIndex: 999,
  			revert: true,      // will cause the event to go back to its
  			revertDuration: 0  //  original position after the drag
  		});
  });

	$('#calendar').fullCalendar({
		
		contentHeight: 600,
		header: {
			left: 'prev,next',
      // center: 'title',
			// right: 'month,agendaWeek,agendaDay'
			right: 'today'
		},
		
		timeFormat: { agenda: 'H(:mm)',  '': 'H(:mm)' },
		
		editable: true,
		
		defaultView: 'agendaDay',
		
		allDayText: '',
		axisFormat: 'H:mm',
		firstHour: 8,
		minTime: 8,
		maxTime: 18,
		defaultEventMinutes: 30,
		
		columnFormat: {
        month: 'ddd',    // Mon
        week: 'ddd d/M', // Mon 9/7
        day: 'dddd d/M'  // Monday 9/7
    },
    
    titleFormat: {
        month: 'MMMM yyyy',                             // September 2009
        week: "d MMM[ yyyy]{ '-'[ d] MMM yyyy}", // Sep 7 - 13 2009    &#8212;
        day: 'dddd, d MMM yyyy'                  // Tuesday, Sep 8, 2009
    },
		
		monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio',
     'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
    
    monthNamesShort:  ['Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu',
      'Lug', 'Ago', 'Set', 'Ott', 'Nov', 'Dic'],
    
    dayNames: ['Domenica', 'Lunedi', 'Martedi', 'Mercoledi', 'Giovedi',
       'Venerdi', 'Sabato'],

    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mer', 'Gio',
          'Ven', 'Sab'],
       
		firstDay: 1,
		
    // slotMinutes: 15,
		
		buttonText: {
        prev:     '&nbsp;&#9668;&nbsp;',  // left triangle
        next:     '&nbsp;&#9658;&nbsp;',  // right triangle
        prevYear: '&nbsp;&lt;&lt;&nbsp;', // <<
        nextYear: '&nbsp;&gt;&gt;&nbsp;', // >>
        today:    'oggi',
        month:    'mese',
        week:     'settimana',
        day:      'giorno'
    },
    
    ignoreTimezone: false,
    
    droppable: true,
    
    // startParam: 'ora_inizio',
    // endParam:   'ora_fine',
    
    events: 'visite.json',
    
    drop: function(date, allDay) { // this function is called when something is dropped

    				// retrieve the dropped element's stored Event Object
    				var originalEventObject = $(this).data('eventObject');

    				// we need to copy it, so that multiple events don't have a reference to the same object
    				var copiedEventObject = $.extend({}, originalEventObject);

    				// assign it the date that was reported
    				copiedEventObject.start = date;
            copiedEventObject.end   = new Date(date.getTime() + 30*60000);
            
    				copiedEventObject.allDay = allDay;
						
				    var x = copiedEventObject.id.split('_');
            console.log(x[1]);
						console.log(copiedEventObject.start);
            
            $.ajax({
              type: 'post',
              data: { 'visita': { 'title': copiedEventObject.title,  'start': copiedEventObject.start.toString(), 'end': copiedEventObject.end.toString() }  },
              url: '/appunti/' + x[1] + '/visite.json',

              success: function(data, textStatus, jqXHR) {
                      copiedEventObject.id = copiedEventObject.id + data.visita.id; 
                      console.log(copiedEventObject.id);
                      $("#assegnati_size").html(parseInt($("#assegnati_size").html()) +1);
                      $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);
              }
            });

    				// render the event on the calendar
    				// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
    				$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
            $(this).remove();
    },
    
    eventResize: function(event,dayDelta,minuteDelta,revertFunc) {

            var x = (event.id).split('_');
            
            $.ajax({
              type: 'put',
              data: { 'visita': { 'start': event.start.toString(), 'end': event.end.toString() }  },
              url: '/appunti/' + x[1] + '/visite/'+x[3]+'.json',
              success: function(data, textStatus, jqXHR) {
                      // copiedEventObject.id = copiedEventObject.id + data.visita.id; 
                      // console.log(copiedEventObject.id);
                      // $("#assegnati_size").html(parseInt($("#assegnati_size").html()) +1);
                      // $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);
                    }
            });
            
            // if (!confirm(
            //           "The end date of " + event.title + " has been moved " +
            //           dayDelta + " days and " +
            //           minuteDelta + " minutes.")) {
            //     revertFunc();
            // } else {
            //   
            // }

    },
    
    eventDrop: function(event,dayDelta,minuteDelta,revertFunc) {
            
            var x = (event.id).split('_');
            
            $.ajax({
              type: 'put',
              data: { 'visita': { 'start': event.start.toString(), 'end': event.end.toString() }  },
              url: '/appunti/' + x[1] + '/visite/'+x[3]+'.json',
              success: function(data, textStatus, jqXHR) {
                      // copiedEventObject.id = copiedEventObject.id + data.visita.id; 
                      // console.log(copiedEventObject.id);
                      // $("#assegnati_size").html(parseInt($("#assegnati_size").html()) +1);
                      // $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);
                    }
            });

    }
	});		
});


/* -----------------
    scroll Menu 
------------------*/
$(document).ready(function () {  
  
  // sbaglia i conti di 4 o 6 pixel mah?
  // var headerOfset = $('#header').outerHeight() + 6;
  // console.log(headerOfset);
  
  $(window).scroll(function() {
    
    var topmenu = $(document).scrollTop();
    // console.log(topmenu);
    if ((topmenu - 100) <= 132) {
      topmenu = $(document).scrollTop() ;
    } else {
      topmenu = topmenu - 100;
    };
    // console.log(topmenu);
    $('#sidebar')
        .stop()
        .animate({top: topmenu},'slow','easeOutBack');
    $('#calendar')
        .stop()
        .animate({top: topmenu},'slow','easeOutBack');
    
  });
});


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
 
 $(".appunto_big").hover(function(){$(this).effect("highlight", {}, 1000);});

});

if (history && history.pushState) {
	
  $(document).ready(function () {  
    
    $('#appunto_nome_scuola').bestupper(); 
 	 	
 	 	// Sorting and pagination links.  
    // $("#appunti .pagination a,  #provincie a").live("click", function() {
    //        $.getScript(this.href);
    //          history.pushState(null, document.title, this.href);
    //          // event.preventDefault();
    //      return false;
    // });
	    
    $("#status_image a").live("click", function() {
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
			history.pushState(null, document.title, $("#scuola_search").attr("action") + "?" +  $("#scuola_search").serialize()); 
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
  			  url: '/scuole/sort',
  				type: 'post',
  				data: $('#scuole_sort_list').sortable('serialize'),
  				dataType: 'script', 
  				complete: function(request){
  					$('#scuole_sort_list').effect('highlight');
  				}
        })
  		}
    });    
		
		$('#da_assegnare').addTouch();
    $( "#assegnati" ).addTouch();
    
    $( "#da_assegnare" ).sortable({
       connectWith: ".connectedSortable",
       opacity: 0.7,
       placeholder: 'appunto_placeholder',
       revert: true,
       remove: function(event, ui) {          
          var x = ui.item.attr('id').split('_');     
          // $('#a_footer', ui.item).hide(); //{'background-color': 'blue'});
          var today = new Date();
          console.log(today)
          $.ajax({
            type: 'post',
            data: { 'visita': {'note': 'ciao tax', 'data': today.toString() } },
            url: '/appunti/' + x[1] + '/visite.json',
            success: function(data) {
              // cambio id appunto
              $(ui.item).attr('id', ui.item.attr('id')+data.visita.id);              
              console.log(ui.item.attr('id'));
              var mark = $.getJSON('/maps/get_appunto_marker/'+x[1]+'.json', function(myMarkers){
                   $("#map_appunti").goMap();
                   console.log(myMarkers[0].latitude);
                   $.goMap.createMarker(myMarkers[0]);
                   
                   $.goMap.fitBounds(); 
              });
              $("#assegnati_size").html(parseInt($("#assegnati_size").html()) +1);
              $("#da_assegnare_size").html(parseInt($("#da_assegnare_size").html()) - 1);  
            }
          })
        }
     }).disableSelection();
   
     $( "#assegnati" ).sortable({
       connectWith: ".connectedSortable",
       opacity: 0.7,
       placeholder: 'appunto_placeholder',
       revert: true,
        remove: function(event, ui) {          
          var x = ui.item.attr('id').split('_');
          $.ajax({
            type: 'delete',
            // data: 'id=' + ui.item.attr('id') + '&db=' + ui.item.attr('offsetParent').id,
            url: '/appunti/' + x[1] + '/visite/' + x[3] +'.json',
            success: function() {
              
              $(ui.item).attr('id', 'appunto_' + x[1] + '_visita_');
              $.getJSON('/maps/get_appunto_marker/'+x[1]+".json", function(data){
                $("#map_appunti").goMap();
                console.log(data[0].id);
                $.goMap.removeMarker(data[0].id);
                $.goMap.fitBounds(); 
              });
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
