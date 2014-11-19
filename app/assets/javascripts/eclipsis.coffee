ready = ->

  $('.text_here2').ThreeDots
    max_rows: 3
    
  $('.oppoptunity-description').ThreeDots
    max_rows: 10

    
	

  
$(document).ready(ready)
$(document).on('page:load', ready)