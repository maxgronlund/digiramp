ready = ->
  soundManager = recreateSoundManager()
  new Heyoffline
    monitorFields: false
    elements: ['.monitoredFields']
  
$(document).ready(ready)
$(document).on('page:load', ready)
