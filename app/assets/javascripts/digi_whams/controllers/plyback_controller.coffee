class @PlaybackController
  # keep track of the need for showing the spinner
  sounds_loaded = {}
  
  
  constructor: ->
    
    # listen for clicks on play button
    $('.play').on 'click', ->
      reset_play_buttons()
      id  = $(this).attr 'id'
      mp3 = $(this).attr 'mp3'
      # count playbacks
      $.getScript("/digiwham/recordings/" + id)
      window.audio_engine.play(id, mp3)
      show_loading_button(id)

    # Set all players to default  
    $('.loading').click =>
      window.audio_engine.pause()
      reset_play_buttons
      id  = $(this).attr 'id'
      show_play_button(id)
     
    $('.pause').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons
      id  = $(this).attr 'id'
      show_play_button(id)
    
    $('.audio-waveform').click (event) ->
      move_playhead( $(this), event)
      

     
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
    width =  $('#'+ id + '.audio-waveform').width()
    $('#'+ id + '.playhead').css 'margin-left': (position * width )
  
  move_playhead = (waveform, event) ->
    id        = waveform.attr 'id'
    width     = waveform.width()
    offset    = waveform.offset()
    position = (event.pageX - offset.left) / width
  
    window.audio_engine.set_position(id, position)
  

  

    
    
      
      
