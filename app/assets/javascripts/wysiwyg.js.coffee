




ready = ->
  
  $('#wysihtml5_editor').wysihtml5 () ->
  	"font-styles": false, 
  	"emphasis": true,
  	"lists": true, 
  	"html": false,
  	"link": true, 
  	"image": true, 
  	"color": false 


$(document).ready(ready)
$(document).on('page:load', ready)



