ready = ->    

  editor = new wysihtml5.Editor("common_work_lyrics", 
    toolbar:        "toolbar",
    parserRules:    wysihtml5ParserRules,
    useLineBreaks:  false
  )

  
$(document).ready(ready)
$(document).on('page:load', ready)
