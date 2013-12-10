# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '197649090421784', cookie: true)

  $('#sign_in').click (e) ->
    e.preventD
    FB.login (response) ->
      if response.authResponse
      	FB.api "/me", (response) ->
      		window.location = '/users/auth/facebook/' 

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

 

initialize = ->
  
  $.ajax
    type: "GET"
    url: '/get_event_data'
    success: (data) ->  
      setMarkers(map, data)

  mapOptions =
    center: new google.maps.LatLng(48.864448880954, 2.3449192563913)
    zoom: 12

  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

  setMarkers = (map, data) ->
    console.log(data)
    i = 0
    while i < data.places.length
      alat = data.places[i].latitude
      along = data.places[i].longitude
      aname =data.events[i].name
      setMarker map, alat, along, aname
      i++

  setMarker = (map, alat, along, aname) ->
    myLatlng = new google.maps.LatLng(alat, along)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
      clickable: true
      animation: google.maps.Animation.DROP    
    )
    contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div>" + "<h1 id=\"firstHeading\" class=\"firstHeading\">"+aname+"</h1>" + "<div id=\"bodyContent\">" + "<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large " + "sandstone rock formation in the southern part of the " + "Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) " + "south west of the nearest large town, Alice Springs; 450&#160;km " + "(280&#160;mi) by road. Kata Tjuta and Uluru are the two major " + "features of the Uluru - Kata Tjuta National Park. Uluru is " + "sacred to the Pitjantjatjara and Yankunytjatjara, the " + "Aboriginal people of the area. It has many springs, waterholes, " + "rock caves and ancient paintings. Uluru is listed as a World " + "Heritage Site.</p>" + "<p>Attribution: Uluru, <a href=\"http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194\">" + "http://en.wikipedia.org/w/index.php?title=Uluru</a> " + "(last visited June 22, 2009).</p>" + "</div>" + "</div>"
    infowindow = new google.maps.InfoWindow(content: contentString)
    google.maps.event.addListener marker, "mouseover", ->
      infowindow.open map, marker
    google.maps.event.addListener marker, "mouseout", ->
      infowindow.close map, marker 
 
google.maps.event.addDomListener window, "load", initialize