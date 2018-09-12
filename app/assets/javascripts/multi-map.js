function initMultiMap() {
  
  var extractCoordinates = function(item) { return item.p; }

  var map = new google.maps.Map(document.getElementById('route-map'), {
    zoom: 4,
    center: {lat: 32, lng: -122},
    mapTypeId: 'terrain'
  });

  var drawRoute = function(boatID, color) {
    var coordinatesEndpoint = '/boats/' + boatID + '/positions.json';

    $.getJSON(coordinatesEndpoint, function(data) {
      var route1 = data.route.map(extractCoordinates); 

      var chartPlot = new google.maps.Polyline({
        path: route1,
        geodesic: true,
        strokeColor: color,
        strokeOpacity: 1.0,
        strokeWeight: 1
      });

      var lastPositionUpdate = new google.maps.Marker({
        icon: {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 6,
          strokeColor: color
        },
        position: route1[0],
        map: map,
        title: 'Latitude: ' + route1[0].lat + ', Longitude: ' + route1[0].lng
      });

      chartPlot.setMap(map);
    });
  }

  drawRoute(1, '#d83413');
  drawRoute(2, '#14a017');
  drawRoute(3, '#7a4f27');

}
