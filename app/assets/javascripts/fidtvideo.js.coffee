ready = ->



  $("#welcome-videos").fitVids()
  
  # Basic FitVids Test
  $(".video-container").fitVids();
  # Custom selector and No-Double-Wrapping Prevention Test
  $(".video-container").fitVids({ customSelector: "iframe[src^='http://socialcam.com']"});



$(document).ready(ready)
$(document).on('page:load', ready)