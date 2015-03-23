ready = ->
  
  if $('.inlineplayer-init')[0]
    soundManager = recreateSoundManager()
    

$(document).ready(ready)
$(document).on('page:load', ready)