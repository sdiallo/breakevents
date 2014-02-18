# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




jQuery ->
resizeback = ->
  h = $(window).height() - $(".home-full").position().top
  $(".home-back,.home-full,.home-doted").height h  if h > 500
  mt = ((h - $("#home-cont").height()) / 2) * 0.8
  $("#home-cont").css paddingTop: mt + "px"  if mt > 50


$(window).resize ->
  resizeback()


$(document).ready ->
  resizeback()

  $(document).on "click", ".home-scroll-down a", ->
    h = $("#home-cont2").position().top
    $("body,html").animate
      scrollTop: h
    , 3000





  $('body').prepend('<div id="fb-root"></div>')

  $("#navtop").affix offset:
    top: 100
  

  $("#masonry-event").masonry
    itemSelector: ".event-wrap"

  $container = $(".masonry-event").masonry()

  # layout Masonry again after all images have loaded
  $container.imagesLoaded ->
    $container.masonry()
   

  $("#eventcar").carousel()

  $('.datetimepicker').datetimepicker()


  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true
  


window.fbAsyncInit = ->
  FB.init(appId: '197649090421784', cookie: true)

  $('#sign_in').click (e) ->
    e.preventDefault
    FB.login (response) ->
      if response.authResponse
      	FB.api "/me", (response) ->
      		window.location = '/user/auth/facebook/' 

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

initialize = ->

  
  $.ajax
    type: "POST"
    url: '/' + cityurl + '/city_events_data'
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
      setMarker map, alat, along, data.events[i]
      i++

  setMarker = (map, alat, along, data) ->
    myLatlng = new google.maps.LatLng(alat, along)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
      clickable: true
      animation: google.maps.Animation.DROP
      title:data.name    
    )
    map.setCenter(myLatlng)
    url = "/events/"+data.id
    contentString = "<a href=\"" + url+ "\" style='font-size: 12px;color: #555;' ><div style='background: #EEE;background-image: -moz-linear-gradient(top,#FEFEFE,#EEE);background-image: -webkit-gradient(linear,left top,left bottom,color-stop(0,#FDFDFD),color-stop(1,#EEE));border: 1px solid #3b5998;-webkit-border-radius: .6em;-border-radius: .6em;-moz-border-radius: .6em;'>" + "<table cellspacing=0 cellpadding=0><tr>" + "<td><img src='" + data.picture.url+ "' border=0 style='height:50px; width:50px; padding: 10px;'></td>" + "<td><span style='color:#3b5998;font-weight:bold'>" + data.name + "</span><br>" + data.location+ " " + data.start_time+ "<br>" + data.end_time + "</td>" + "</tr></table><img src='http://allevents.in/images/map_arrow.png' style='position: absolute;padding: 0;left: 50%;margin-top: -3px;'/></div></a>"
    infowindow = new google.maps.InfoWindow(content: contentString)
    google.maps.event.addListener marker, "mouseover", ->
      infowindow.open map, marker
    google.maps.event.addListener marker, "mouseout", ->
      infowindow.close map, marker

 
google.maps.event.addDomListener window, "load", initialize