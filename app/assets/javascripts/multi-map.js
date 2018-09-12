function initMultiMap() {

  var route1;
  
  var extractCoordinates = function(item) { return item.p; }

  var map = new google.maps.Map(document.getElementById('route-map'), {
    zoom: 4,
    center: {lat: 38.6335682, lng: -122.7617397},
    mapTypeId: 'terrain'
  });


  var boatIDs = [1,3];
  var arrayLength = boatIDs.length;
  for (var i = 0; i < arrayLength; i++) {
    var coordinatesEndpoint = '/boats/' + boatIDs[i] + '/positions.json';

    $.getJSON(coordinatesEndpoint, function(data) {
      route1 = data.route.map(extractCoordinates); 

      var chartPlot = new google.maps.Polyline({
        path: route1,
        geodesic: true,
        strokeColor: '#024ec9',
        strokeOpacity: 1.0,
        strokeWeight: 1
      });

      var lastPositionUpdate = new google.maps.Marker({
        position: route1[0],
        map: map,
        title: 'Latitude: ' + route1[0].lat + ', Longitude: ' + route1[0].lng + ' ...Click for more info'
      });

      var date = new Date(data.route[0].t * 1000);
      var hours = date.getHours();
      var minutes = "0" + date.getMinutes();
      var dateTimeString = date + ' at ' + hours + ':' + minutes.substr(-2);

      var contentString = '<p><strong>Position</strong></p>' +
                          '<p>Latitude: ' + route1[0].lat + ', Longitude: ' + route1[0].lng + '</p>' +
                          '<p><strong>Last Report</strong></p>' +
                          '<p>' + dateTimeString + '</p>';

      var infowindow = new google.maps.InfoWindow({
        content: contentString
      });

      lastPositionUpdate.addListener('click', function() {
        infowindow.open(map, lastPositionUpdate);
      });

      chartPlot.setMap(map);
    });
  }
}
