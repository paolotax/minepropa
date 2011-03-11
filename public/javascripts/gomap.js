$(document).ready(function() {
  
  var scu_id  =$('.scuola_id').text();
  console.log(scu_id);
  var url = scu_id + ".json";
  
  var mark = $.getJSON(url, function(myMarkers){
     $("#map").goMap({
         markers: myMarkers,
         zoom: 15,
         maptype:	'ROADMAP',
         streetViewControl: true
     });
  });  
  
  var centerlat  = 56.9;
	var centerlong = 24.1;
	var zoom = 6;
	var MERCATOR_RANGE = 256;
 
 
	rad = function(x) {return x*Math.PI/180;}
 
	distHaversine = function(p1, p2) {
		var R = 6371; // earth's mean radius in km
		var dLat  = rad(p2.lat() - p1.lat());
		var dLong = rad(p2.lng() - p1.lng());
 
		var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
			Math.cos(rad(p1.lat())) * Math.cos(rad(p2.lat())) * Math.sin(dLong/2) * Math.sin(dLong/2);
		var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		var d = R * c;
 
		return d.toFixed(3);
	}
 
	function bound(value, opt_min, opt_max) {
		if (opt_min != null) value = Math.max(value, opt_min);
		if (opt_max != null) value = Math.min(value, opt_max);
		return value;
	}
 
	function degreesToRadians(deg) {
		return deg * (Math.PI / 180);
	}
 
	function radiansToDegrees(rad) {
		return rad / (Math.PI / 180);
	}
 
	function MercatorProjection() {
		this.pixelOrigin_ = new google.maps.Point(MERCATOR_RANGE / 2, MERCATOR_RANGE / 2);
		this.pixelsPerLonDegree_ = MERCATOR_RANGE / 360;
		this.pixelsPerLonRadian_ = MERCATOR_RANGE / (2 * Math.PI);
	};
 
	MercatorProjection.prototype.fromLatLngToPoint = function(latLng, opt_point) {
		var me = this;
		var point = opt_point || new google.maps.Point(0, 0);
		var origin = me.pixelOrigin_;
		point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_;
		// NOTE(appleton): Truncating to 0.9999 effectively limits latitude to
		// 89.189.  This is about a third of a tile past the edge of the world tile.
		var siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999, 0.9999);
		point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) * -me.pixelsPerLonRadian_;
		return point;
	};
 
	MercatorProjection.prototype.fromPointToLatLng = function(point) {
		var me = this;
		var origin = me.pixelOrigin_;
		var lng = (point.x - origin.x) / me.pixelsPerLonDegree_;
		var latRadians = (point.y - origin.y) / -me.pixelsPerLonRadian_;
		var lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2);
		return new google.maps.LatLng(lat, lng);
	};
 
	$("#map2").goMap({
			latitude:				centerlat,
			longitude:				centerlong,
			zoom: zoom
	});
 
	$.goMap.setMap({draggableCursor: "crosshair"});
 
	var projection = new MercatorProjection();
 
	$("#d_mapcenter").text(centerlat + ',' + centerlong);
	$("#d_mapZoom").text(zoom);
 
	$.goMap.createMarker({
			latitude:				centerlat,
			longitude:				centerlong,
			id: 'baseMarker',
			draggable: true
	});
 
	$.goMap.createListener({type:'marker', marker:'baseMarker'}, 'dragend', function() { 
		setInfoPosition();
    }); 
 
	function randomMarkersFirst() {
		reloadData();
		var bounds = $.goMap.getBounds();
		var southWest = bounds.getSouthWest();
		var northEast = bounds.getNorthEast();
		var lngSpan = northEast.lng() - southWest.lng();
		var latSpan = northEast.lat() - southWest.lat();
 
		for (var i = 0; i < 25; i++) {
			$.goMap.createMarker({
				latitude: southWest.lat() + latSpan * Math.random(),
				longitude: southWest.lng() + lngSpan * Math.random(),
				html: { content: ''},
				icon: 'http://www.google.com/intl/en_ALL/mapfiles/marker_green'+String.fromCharCode(i + 65)+'.png'
			});
		}
 
		setInfoPosition();
	}
 
	function randomMarkers() {
		var bounds = $.goMap.getBounds();
		var southWest = bounds.getSouthWest();
		var northEast = bounds.getNorthEast();
		var lngSpan = northEast.lng() - southWest.lng();
		var latSpan = northEast.lat() - southWest.lat();
 
		for (var i in $.goMap.markers) {
			if ($.goMap.markers[i] != 'baseMarker') {
				$.goMap.setMarker($.goMap.markers[i], {latitude: southWest.lat() + latSpan * Math.random(), longitude: southWest.lng() + lngSpan * Math.random()});
			}
		}
 
		setInfoPosition();
	}
 
	function setInfoPosition() {
		var baseMarkerPosition = $("#map2").data("baseMarker").getPosition();
 
		for (var i in $.goMap.markers) {
			if ($.goMap.markers[i] != 'baseMarker') {
					var html = 'Distance to base: ' + distHaversine($("#map2").data($.goMap.markers[i]).getPosition(), baseMarkerPosition) + ' km';
					$.goMap.setInfo($.goMap.markers[i], html); 
			}
		}
	}
 
	setTimeout(function() {
		randomMarkersFirst();
	}, 500);
 
 
	$.goMap.createListener({type:'map'}, 'mousemove', reloadDataMouse);
 
	$.goMap.createListener({type:'map'}, 'click', reloadDataMouseClick);
 
	$.goMap.createListener({type:'map'}, 'dragend', reloadData);
 
	$.goMap.createListener({type:'map'}, 'zoom_changed', reloadData);
 
 
	function reloadData() {
		var bounds = $.goMap.getBounds();
 
		$("#d_mapcenter").text($.goMap.map.getCenter().toUrlValue(6));
		$("#d_SouthWest").text(bounds.getSouthWest().toUrlValue(6));
		$("#d_northEast").text(bounds.getNorthEast().toUrlValue(6));
		$("#d_mapZoom").text($.goMap.map.getZoom());
	}
 
	function reloadDataMouse(event) {
		$("#d_mouseLatLon").text(event.latLng.toUrlValue(6));
 
		var mapZoom = $.goMap.map.getZoom();
		var worldCoordinate = projection.fromLatLngToPoint(event.latLng);
		var pixelCoordinate = new google.maps.Point(worldCoordinate.x * Math.pow(2, mapZoom), worldCoordinate.y * Math.pow(2, mapZoom));
		$("#d_DivPixel").text(Math.floor(pixelCoordinate.x) + "," + Math.floor(pixelCoordinate.y));
 
		var tileCoordinate = new google.maps.Point(Math.floor(pixelCoordinate.x / MERCATOR_RANGE), Math.floor(pixelCoordinate.y / MERCATOR_RANGE));
		$("#d_Tile").text(tileCoordinate.x + "," + tileCoordinate.y);
	};
 
	function reloadDataMouseClick(event) {
		$("#d_mouseClick").text(event.latLng.toUrlValue(6));
	};
 
	$("#random").click(function(){ 
		randomMarkers();
	});
 
 
	$("#default").click(function(){ 
		$("#dump").html($.dump($.goMap.getMarkers()));
	});
 
 
	$("#json").click(function(){ 
		$("#dump").html($.goMap.getMarkers("json"));
	});
 
	$("#data").click(function(){ 
		$("#dump").html($.goMap.getMarkers("data"));
	});

});  
