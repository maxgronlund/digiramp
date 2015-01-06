ready = ->
  $(".toggle").toggles
    text:
      on: "Yes" 
      off: "No"

  
  $(".toggle").on "toggle", (e, active) ->
    if active
      #alert $(this).attr 'id'
    else
      #alert 'off'
    return
  

  
$(document).ready(ready)
$(document).on('page:load', ready)