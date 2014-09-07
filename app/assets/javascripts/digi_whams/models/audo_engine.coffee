# wrapper around soundmanager2
class @AudioEngine
  sm_sounds = {}
  playing = false

  constructor: ->
  
  play: (id, mp3) ->
    playing = true
    soundManager.pauseAll()
    create_sound(id , mp3)

  pause: ->
    playing = false
    soundManager.pauseAll()
    
  initialize: ->
    setup_soundmanager()
      
  setup_soundmanager = () ->
    if window.soundManager.ok() 
      window.soundManager.stopAll()
      

  create_sound = (id, mp3) ->
    
    unless sm_sounds[id]
      sm_sound  = soundManager.createSound( {id: 'sound_' + id, url: mp3, } )
      sm_sounds[id]                  = sm_sound  
      sm_sounds[id]['sound_loading'] = true
      sm_sounds[id].load( 
        whileloading: ->
          window.digi_wahms_controller.set_loadbar( id, this.bytesLoaded / this.bytesTotal ) 
      )

    sm_sounds[id].play(
      
      whileplaying: ->
        if this.position and sm_sounds[id]['sound_loading']
          sm_sounds[id]['sound_loading'] = false
          window.digi_wahms_controller.sound_loaded(id)
        else if this.position
          playhead_position               = this.position / this.durationEstimate
          window.digi_wahms_controller.set_playhead( id, playhead_position )
          sm_sounds[id]['durationEstimate'] = this.durationEstimate
          
          window.playhead_display.set_text( id, this.position, playhead_position )
    )
    
  set_position: (id, possition) ->
    possition *= sm_sounds[id]['durationEstimate']
    sm_sounds[id].setPosition( possition )
    
  is_playing: ->
    playing
    
    