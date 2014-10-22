class @PlaybackController
  # keep track of the need for showing the spinner
  sounds_loaded = {}
  id  = -1
  mp3 = ''
  
  global_id  = -1
  global_mp3 = ''
  window.song_title   = ''
  window.song_artist  = ''
  
  constructor: ->
    
    # listen for clicks on play button
    $('.play').on 'click', ->
      reset_play_buttons()
      id        = $(this).attr 'id'
      mp3       = $(this).attr 'mp3'
      $.getScript("/digiwham/recordings/" + id )
      window.audio_engine.play(id, mp3)
      show_loading_button(id)
      
      window.song_title   =  $(".recording_title_" + id).text()
      window.song_artist  =  $(".recording_artist_" + id).text()
      $('.global-player-song-title').text(window.song_title)
      $('.global-player-song-artist').text(window.song_artist)
      


    # Set all players to default  
    $('.loading').on 'click', ->
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
      
    $('.global-stop-button').on 'click', ->
      global_id  = id
      global_mp3 = mp3
      window.audio_engine.pause()
      reset_play_buttons
      show_play_button(id)
      #set_global_play(false)
      console.log global_id  
      
    $('.global-play-button').on 'click', ->
      reset_play_buttons()
      $.getScript("/digiwham/recordings/" + global_id  )
      window.audio_engine.play(global_id, global_mp3 )
      show_loading_button(global_id)
      #console.log global_id
    

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
    set_global_play(true)

  show_play_button = (id) ->
    $('#'+ id + '.play').css("display", 'block')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'none')
    set_global_play(false)
      
  show_loading_button = (id) ->
    # if sound is unloaded show the spinner
    if( typeof sounds_loaded[id] == "undefined")
      $('#'+ id + '.play').css("display", 'none')
      $('#'+ id + '.loading').css("display", 'block')
      $('#'+ id + '.pause').css("display", 'none')
      set_global_play(false)
    else
      show_stop_button(id)
      set_global_play(true)
      
    
  show_stop_button = (id) ->
    $('#'+ id + '.play').css("display", 'none')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'block')
    set_global_play(true)
    
  
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
  refresh_global_player: () ->
    set_global_play( window.audio_engine.is_playing() )
    $('.global-player-song-title').text(window.song_title)
    $('.global-player-song-artist').text(window.song_artist)

  
  # shift buttons on global player    
  set_global_play =(state) ->
    if state
      $('.global-play-button').css 'display': 'none'
      $('.global-stop-button').css 'display': 'inline'
    else
      $('.global-play-button').css 'display': 'inline'
      $('.global-stop-button').css 'display': 'none'

      
      
  

  

    
    
      
      
