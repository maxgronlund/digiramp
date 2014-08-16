# make sure it works with turbolinks
ready = ->
 digiWhamsNamespace.loadWhams()
  

  
$(document).ready(ready)
$(document).on('page:load', ready)



