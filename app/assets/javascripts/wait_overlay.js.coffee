


ready = ->
  
  $('.please_wait').click ->
    $.blockUI css:
      border: "none"
      padding: "15px"
      backgroundColor: "#000"
      "-webkit-border-radius": "10px"
      "-moz-border-radius": "10px"
      opacity: .5
      color: "#fff"
    
    setTimeout($.unblockUI, 20000)


$(document).ready(ready)
$(document).on('page:load', ready)



