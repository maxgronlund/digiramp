# http://css-tricks.com/jquery-coffeescript/
# keep everything inside a namespace

class @DigiWhamsController
  
  playback_controller = {}
  comments_controller = {}
  bottoms_controller = {}
  
  
  constructor: ->
    # request recordings from backend
    if ($('#digiWhams')[0])
      #console.log '--------------------------------------'
      secret_key = $('#digiWhams').attr("class")
      $.getScript("/digiwham/recordings/?key=" + secret_key  )
      #$.getScript("/digiwham/recordings")


  # public function called when all players are loaded    
  initialize: (root) ->

    playback_controller   = new PlaybackController
    comments_controller   = new CommentsController
    bottoms_controller    = new BottomsController
    #playback_controller.initialize()

  # wrapper function
  set_loadbar: (id, progress) ->
    playback_controller.set_loadbar id, progress
  sound_loaded: (id) ->
    playback_controller.sound_loaded( id )
    
  set_playhead: (id, position) ->
    playback_controller.set_playhead( id, position )