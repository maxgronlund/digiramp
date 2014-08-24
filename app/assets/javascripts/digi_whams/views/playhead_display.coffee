# wrapper around soundmanager2
class @PlayheadDisplay

  constructor: ->

  set_text: (id, position, playhead_position) ->
    update_display( id, convertTimeToString(position * 0.001) )
    
    width =  $('#'+ id + '.audio-waveform').width()
    margin_left = (playhead_position * width) - 22
    
    if margin_left < 0
      margin_left = 0
    if margin_left > width - 44
      margin_left = width  - 44
      
    $('#'+ id + '.playhead-time').css 'margin-left': margin_left 
    
    
  update_display = ( id, text ) ->
    $('#'+ id + '.playhead-time').text( text )

  convertTimeToString = (timeFloat) ->
    hours   = parseInt(timeFloat / 3600)
    minutes = parseInt(timeFloat / 60) - hours
    seconds = parseInt(timeFloat) - (minutes * 60)
    msec    = parseInt(timeFloat * 100) - (parseInt(timeFloat) * 100)
    text = convertToTwoDigitString(minutes) + ':' + convertToTwoDigitString(seconds) + ':' + convertToTwoDigitString(msec)
    

  convertToTwoDigitString = (inInt) ->
    if inInt < 10
      return "0" + inInt
    inInt