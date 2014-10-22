class @PlaybackController
  # keep track of the need for showing the spinner
  sounds_loaded = {}
  id  = 0
  mp3 = ''
  
  constructor: ->
    
    # listen for clicks on play button
    $('.play').on 'click', ->
      reset_play_buttons()
      id        = $(this).attr 'id'
      mp3       = $(this).attr 'mp3'
      $.getScript("/digiwham/recordings/" + id )
      window.audio_engine.play(id, mp3)
      show_loading_button(id)
      set_global_player_state(true)

    
    # Set all players to default  
    $('.loading').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons
      id  = $(this).attr 'id'
      show_play_button(id)
      set_global_player_state(false)
     
    
    $('.pause').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons
      id  = $(this).attr 'id'
      show_play_button(id)
      set_global_player_state(false)

    
    $('.audio-waveform').click (event) ->
      move_playhead( $(this), event)
      
    $('.global-stop-button').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons
      show_play_button(id)
      set_global_player_state(false)
      
    $('.global-play-button').on 'click', ->
      reset_play_buttons()
      $.getScript("/digiwham/recordings/" + id )
      window.audio_engine.play(id, mp3)
      set_global_player_state(true)
     
  # when a play button is pressed reset all buttons    
  reset_play_buttons = () ->
    $('.play').each (index, element) =>
      id = $(element).attr('id')
      show_play_button(id)
      
  set_loadbar: (id, progress) ->
    $('#'+ id + '.loadbar').css 'width': (progress * 100) + "%"   
    
  sound_loaded: (id ) ->
    sounds_loaded[id] = true
    show_stop_button(id)

  show_play_button = (id) ->
    $('#'+ id + '.play').css("display", 'block')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'none')
      
  show_loading_button = (id) ->
    # if sound is unloaded show the spinner
    if( typeof sounds_loaded[id] == "undefined")
      $('#'+ id + '.play').css("display", 'none')
      $('#'+ id + '.loading').css("display", 'block')
      $('#'+ id + '.pause').css("display", 'none')
    else
      show_stop_button(id)
    
  show_stop_button = (id) ->
    $('#'+ id + '.play').css("display", 'none')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'block')
    
  
  set_playhead: (id, position) ->
     set_playhead(id, position)
  
  set_playhead = (id, position) ->
    width =  $('#'+ id + '.audio-waveform').width() - 1
    $('#'+ id + '.playhead').css 'margin-left': (position * width )
  
  move_playhead = (waveform, event) ->

    if window.audio_engine.is_playing()
      id        = waveform.attr 'id'
      width     = waveform.width()
      offset    = waveform.offset()
      position = (event.pageX - offset.left) / width
      window.audio_engine.set_position(id, position)
      
  # maintain playstate when entering a new page
  refresh_global_player: ->
      set_global_player_state( window.audio_engine.is_playing() )

  
  # shift buttons on global player    
  set_global_player_state =(state) ->
    if state
      $('.global-play-button').css 'display': 'none'
      $('.global-stop-button').css 'display': 'inline'
    else
      $('.global-play-button').css 'display': 'inline'
      $('.global-stop-button').css 'display': 'none'

      
      
  

  

    
    
      
      
