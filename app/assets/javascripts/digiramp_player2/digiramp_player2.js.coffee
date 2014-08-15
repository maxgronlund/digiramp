

ready = ->
  console.log('fobar')

  
$(document).ready(ready)
$(document).on('page:load', ready)
