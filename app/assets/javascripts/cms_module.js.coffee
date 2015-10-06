ready = ->

  $('#cms_section_cms_type').change ->

    #alert $('option:selected').val() 
    $.getScript("/cms_modules/" + $('option:selected').val() ) 

    return

  


$(document).ready(ready)
$(document).on('page:load', ready)