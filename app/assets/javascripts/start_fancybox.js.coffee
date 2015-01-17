#$(document).bind "page:change", ->
#  $(".fancybox").fancybox parent: "body"
#  return

ready = ->
  #$('.fancybox').fancybox()
  $(".fancybox").fancybox parent: "body"


$(document).ready(ready)
$(document).on('page:load', ready)



