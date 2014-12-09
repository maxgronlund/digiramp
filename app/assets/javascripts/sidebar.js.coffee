ready = ->
  
  $("#menu-toggle").click (e)->
    e.preventDefault()
    $("#wrapper").toggleClass("toggled")
    
  $("#sidebar-toggle").click (e)->
    e.preventDefault()
    $("#wrapper").toggleClass("toggled")
    
  $( window ).resize ->
    if $(window).width() > 753
      $('#wrapper').toggleClass("toggled", false)
      
      

  

  

  
$(document).ready(ready)
$(document).on('page:load', ready)