

# make sure it works with turbolinks
ready = ->
  
  window.digi_wahms_controller = new DigiWhamsController
  window.audio_engine          = new AudioEngine
  window.playhead_display      = new PlayheadDisplay

  
$(document).ready(ready)
$(document).on('page:load', ready)





# public function called from views/digi_wham_resources/index.js.erb
# when all recordings are loaded    
@initialize =()  ->
  window.digi_wahms_controller.initialize()
  window.audio_engine.initialize()