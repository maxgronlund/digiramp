ready = ->
  console.log 'readdy'
  window.digi_wahms_controller = new DigiWhamsController
  window.audio_engine          = new AudioEngine
  window.playhead_display      = new PlayheadDisplay
  #initialize_digi_wahms()
  
  
  
  
$(document).ready(ready)
$(document).on('page:load', ready)



# public function called from views/digi_wham_resources/index.js.erb
# when all recordings are loaded    
@initialize_digi_wahms =()  ->
  
  window.digi_wahms_controller.initialize()
  window.audio_engine.initialize()
  
  window.digi_wahms_controller.refresh_global_player()
  
  
  