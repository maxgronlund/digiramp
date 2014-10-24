# http://css-tricks.com/jquery-coffeescript/
# keep everything inside a namespace

class @DigiWhamsController
  
  playback_controller = {}
  #comments_controller = {}
  #bottoms_controller  = {}
  
  
  
  
  
  constructor: ->
    # request recordings from backend
    if $('#digiWhams')[0]
      
      controller = $('#digiWhams').attr("class")
      console.log '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
      console.log controller 
      if(controller?) 
        $.getScript( controller)



  # public function called when all players are loaded    
  initialize: (root) ->

    playback_controller   = new PlaybackController
    #comments_controller   = new CommentsController
    #bottoms_controller    = new BottomsController
    
    

  # wrapper function
  set_loadbar: (id, progress) ->
    playback_controller.set_loadbar id, progress
  sound_loaded: (id) ->
    playback_controller.sound_loaded( id )
    
  set_playhead: (id, position) ->
    playback_controller.set_playhead( id, position )
    
  
  set_width =() ->
    width =  $("#digi_width").width()
    $(".digiwham_iframe").each (index, element) =>
      $(element).css("width", width )
    

  $( window ).resize ->
    if $("#digi_width")[0] 
      set_width()

      
  $(document).ready(set_width)
  $(document).on('page:load', set_width)
  
  refresh_global_player: () ->
    
    if(playback_controller.refresh_global_player?)
      playback_controller.refresh_global_player()
  

      

