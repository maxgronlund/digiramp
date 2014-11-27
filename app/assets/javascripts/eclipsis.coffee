ready = ->

  $('.text_here2').ThreeDots
    max_rows: 3
    
  $('.oppoptunity-description').ThreeDots
    max_rows: 10
    
  $('.following-profile').ThreeDots
    max_rows: 3

    
	

  
$(document).ready(ready)
$(document).on('page:load', ready)