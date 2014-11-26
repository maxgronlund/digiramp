class @PlaybackController
  # keep track of the need for showing the spinner
  sounds_loaded = {}
  window.global_id    = -1
  window.global_mp3   = ''
  window.song_title   = ''
  window.song_artist  = ''
  
  constructor: ->
    
    # listen for clicks on play button
    $('.play').on 'click', ->
      
      reset_play_buttons()
      window.global_id   = $(this).attr 'id'
      window.global_mp3  = $(this).attr 'mp3'
      $.getScript("/digiwham/recordings/" + window.global_id    )
      window.audio_engine.play(window.global_id   , window.global_mp3)
      show_loading_button( window.global_id )
      set_title_artist_on_global_player(window.global_id )
      


    # Set all players to default  
    $('.loading').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons()
      window.global_id   = $(this).attr 'id'
      show_play_button(window.global_id   )
      
     
    
    $('.pause').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons()
      window.global_id   = $(this).attr 'id'
      show_play_button(window.global_id   )
      

    
    $('.audio-waveform').click (event) ->
      move_playhead( $(this), event)
    
    connect_global_buttons()  
    #$('.global-stop-button').on 'click', ->
    #  console.log 'global-stop-button'
    #  window.audio_engine.pause()
    #  reset_play_buttons()
    #  show_play_button(window.global_id )
    #  #set_global_play(false)
    #  #console.log global_id  
    #  
    #$('.global-play-button').on 'click', ->
    #  console.log window.global_id
    #  if( window.global_id != -1)
    #    reset_play_buttons()
    #    $.getScript("/digiwham/recordings/" +      window.global_id  )
    #    window.audio_engine.play(window.global_id, window.global_mp3 )
    #    
    #    show_loading_button( window.global_id )
      
    

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
    # player
    $('#'+ id + '.play').css("display", 'block')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'none')
    # global player
    $('.global-play-button').css  'display': 'inline'
    $('.global-spinner').css      'display': 'none'
    $('.global-stop-button').css  'display': 'none'
    
    #set_global_play(false)
      
  show_loading_button = (id) ->
    
    if( sounds_loaded[id]?)
      show_stop_button(id)
      #set_global_play(true)
    else
      # sound not loaded show the spinner
      $('#'+ id + '.play').css("display", 'none')
      $('#'+ id + '.loading').css("display", 'block')
      $('#'+ id + '.pause').css("display", 'none')
      # global player
      $('.global-play-button').css  'display': 'none'
      $('.global-spinner').css      'display': 'inline'
      $('.global-stop-button').css  'display': 'none'
      #set_global_play(false)
      
    
  show_stop_button = (id) ->
    $('#'+ id + '.play').css("display", 'none')
    $('#'+ id + '.loading').css("display", 'none')
    $('#'+ id + '.pause').css("display", 'block')
    # global player
    $('.global-play-button').css  'display': 'none'
    $('.global-spinner').css      'display': 'none'
    $('.global-stop-button').css  'display': 'inline'
    
    
  set_title_artist_on_global_player = (id) ->
    window.song_title   =  $(".recording_title_"  + id).text()
    window.song_artist  =  $(".recording_artist_" + id).text()
    $('.global-player-song-title').text( window.song_title)
    $('.global-player-song-artist').text(window.song_artist)
  
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
      
  connect_global_buttons = () ->
    $('.global-stop-button').on 'click', ->
      window.audio_engine.pause()
      reset_play_buttons()
      show_play_button(window.global_id )
      
    $('.global-play-button').on 'click', ->
      if( window.global_id != -1)
        reset_play_buttons()
        $.getScript("/digiwham/recordings/" +      window.global_id  )
        window.audio_engine.play(window.global_id, window.global_mp3 )
        show_loading_button( window.global_id )
      
  # maintain playstate when entering a new page
  refresh_global_player: () ->
    # play button
    if window.audio_engine.is_playing()
      $('.global-play-button').css 'display': 'none'
      $('.global-stop-button').css 'display': 'inline'
    else
      $('.global-play-button').css 'display': 'inline'
      $('.global-stop-button').css 'display': 'none'
    # title artist
    $('.global-player-song-title').text(window.song_title)
    $('.global-player-song-artist').text(window.song_artist)
    connect_global_buttons()
    
    


      
      
  

  

    
    
      
      
