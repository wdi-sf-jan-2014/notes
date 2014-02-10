// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function initialize() {
	var center = new google.maps.LatLng(37.7723412,-122.4379276);
	var mapOptions = {
 	 center: center, 
 	 zoom: 12
	};
	var map = new google.maps.Map(document.getElementById("map-canvas"),
  	  mapOptions);

  for (var i = 0; i < gon.locations.length; i++) {
    var latLongPos = new google.maps.LatLng(gon.locations[i].lat,gon.locations[i].long);
    var temp_marker = new google.maps.Marker({
      position: latLongPos,
      map: map,
      title:"Location " + i
    }); 
  }
}
google.maps.event.addDomListener(window, 'load', initialize);
