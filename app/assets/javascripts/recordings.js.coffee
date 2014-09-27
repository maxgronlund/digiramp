ready = ->
  
  if $('.digiramp_player')[0]
    soundManager = recreateSoundManager()
    

  $('#playlist_recording_ids').chosen()

  
  
  

  
$(document).ready(ready)
$(document).on('page:load', ready)
