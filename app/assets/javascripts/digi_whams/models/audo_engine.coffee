# wrapper around soundmanager2
class @AudioEngine
  sm_sounds = {}

  constructor: ->
  
  play: (id, mp3) ->
    soundManager.pauseAll()
    create_sound(id , mp3)

  pause: ->
    soundManager.pauseAll()
    
  initialize: ->
    setup_soundmanager()
      
  setup_soundmanager = () ->
    if window.soundManager.ok() 
      window.soundManager.stopAll()
      console.log 'soundmanager ok and all sounds stopped'

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
    
    
  #update_display = ( id, text ) ->
  #  $('#'+ id + '.playhead-time').text( text )
  #
  #  
  #convertTimeToString = (timeFloat) ->
  #  hours   = parseInt(timeFloat / 3600)
  #  minutes = parseInt(timeFloat / 60) - hours
  #  seconds = parseInt(timeFloat) - (minutes * 60)
  #  msec    = parseInt(timeFloat * 100) - (parseInt(timeFloat) * 100)
  #  text = convertToTwoDigitString(minutes) + ':' + convertToTwoDigitString(seconds) + ':' + convertToTwoDigitString(msec)
  #  
  #  
  #
  #
  #convertToTwoDigitString = (inInt) ->
  #  if inInt < 10
  #    return "0" + inInt
  #  inInt
    
    
    
  #$(possition_tag).text(convertTimeToString(this.position * 0.001));
  