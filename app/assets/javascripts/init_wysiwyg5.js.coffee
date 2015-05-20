ready = ->  
  
  
  if $("#wysihtml5_editor").length > 0
    editor = new wysihtml5.Editor("wysihtml5_editor", 
      toolbar:        "toolbar",
      parserRules:    wysihtml5ParserRules,
      useLineBreaks:  true
    )
  
  
 

$(document).ready(ready)
$(document).on('page:load', ready)
