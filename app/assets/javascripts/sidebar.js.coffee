ready = ->
  
  $("#menu-toggle").click (e)->
    e.preventDefault()
    $("#wrapper").toggleClass("toggled")

  

  

  
$(document).ready(ready)
$(document).on('page:load', ready)