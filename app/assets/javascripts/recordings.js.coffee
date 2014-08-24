ready = ->
  
  if $('.digiramp_player')[0]
    soundManager = recreateSoundManager()
  
  

  
$(document).ready(ready)
$(document).on('page:load', ready)
