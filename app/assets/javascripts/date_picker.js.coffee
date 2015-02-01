ready = ->

  $('#datetimepicker5').datetimepicker 
  		pickTime: false

  $('#datetimepicker52').datetimepicker 
  		pickTime: false
    
	

  
$(document).ready(ready)
$(document).on('page:load', ready)