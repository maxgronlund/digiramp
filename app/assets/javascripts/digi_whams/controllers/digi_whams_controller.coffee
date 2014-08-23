# http://css-tricks.com/jquery-coffeescript/
# keep everything inside a namespace



class @DigiWhamsController
  
  playback_controller = {}
  
  constructor: ->
    # request recordings from backend
    if ($('#digiWhams')[0])
      $.getScript("/api/digi_wham_resources" )
      $.getScript("/digiwham/recordings" )
      
  # when a play button is pressed reset all buttons    
  build_audio_channel = (id) ->
    #console.log id

  # expand the comments frame on a track
  show_playlists = (recording_id) ->
    close_bottom_pane()
    
    if $('#'+recording_id+'.playlists').is(":hidden")
      $('#'+recording_id+'.playlists').slideDown(400)
    else
      $('#'+recording_id+'.playlists').slideUp(400)
    
  # expand the comments frame on a track
  show_comments = (recording_id) ->
    close_bottom_pane()
    
    if $('#'+recording_id+'.comments').is(":hidden")
      $('#'+recording_id+'.comments').slideDown(400)
    else
      $('#'+recording_id+'.comments').slideUp(400)
      
   
  

  hide_comments =() ->
    $('.comments').each (index, element) =>
      $(element).slideUp(400)
 

  hide_playlists =() ->
    $('.playlists').each (index, element) =>
      $(element).slideUp(400)

  # close open bottom frames  
  close_bottom_pane =() ->    
    hide_comments()
    hide_playlists()
  
  
  # pick up mouse clicks on the play button    
  connect_buttons =() ->
    
    playback_controller  = new PlaybackController
    

    #$('.add_to_playlist').on 'click', ->
    #  alert $(this).attr 'id' 
    $('.add_to_playlist').on 'click', ->
      show_playlists( $(this).attr 'id' )
    
    $('.like').on 'click', ->
      alert $(this).attr 'id' 
    
    $('.share').on 'click', ->
      alert $(this).attr 'id' 
    
    $('.comment').on 'click', ->
      show_comments( $(this).attr 'id' )
    

    $('.audio-waveform').on "click", (event) ->
      waveform_width  = $(this).width()
      offset          = $(this).offset()
      mouse_pos_x     = event.pageX - offset.left    
      id              =    $(this).attr 'id'    
      $("#"+id+".playhead").css("margin-left": 100);
    
      #alert mouse_pos_x / waveform_width  




  # public function called when all players are loaded    
  connect_to_interface: ->

    $('.digi-wham').each (index, element) =>
      build_audio_channel( $(element).attr('id') ) 
      #console.log $(element).attr('mp3')
    

    connect_buttons()
    
    



#@digiwhams_controller.say_hello