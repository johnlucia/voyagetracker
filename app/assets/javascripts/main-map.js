function initRouteMap() {

  var route1
  var coordinatesEndpoint = '/boats/' + window.mappedBoat + '/positions.json';
  var extractCoordinates = function(item) { return item.p; }

  $.getJSON(coordinatesEndpoint, function(data) {
    route1 = data.route.map(extractCoordinates); 

    var map = new google.maps.Map(document.getElementById('route-map'), {
      zoom: 6,
      center: route1[0],
      mapTypeId: 'terrain'
    });

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

    $('#position-report-details').html(contentString);


    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    lastPositionUpdate.addListener('click', function() {
      infowindow.open(map, lastPositionUpdate);
    });

    chartPlot.setMap(map);
  });
}
