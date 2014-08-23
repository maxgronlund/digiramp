class @PlaybackController
  constructor: ->
    console.log 'PlaybackController created'
    $('.play').on 'click', ->
      reset_play_buttons()
      id = $(this).attr 'id'
      $('#'+ id + '.play').css("display", 'none')
      $('#'+ id + '.loading').css("display", 'block')
      $('#'+ id + '.stop').css("display", 'none')
    
     
    # Set all players to default  
    $('.loading').click =>
      reset_play_buttons()
  
    $('.pause').on 'click', ->
      alert $(this).attr 'id'
      
      
  # when a play button is pressed reset all buttons    
  reset_play_buttons = () ->
    $('.play').each (index, element) =>
      id = $(element).attr('id')
      $('#' + id  + '.play').css("display", 'block')
      $('#' + id  + '.loading').css("display", 'none')
      $('#' + id  + '.pause').css("display", 'none')
      
  say_hello: ->
    console.log 'hello from playback'