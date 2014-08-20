# http://css-tricks.com/jquery-coffeescript/
# keep everything inside a namespace
window.digiWhamsNamespace = {}


#  digiWhamsNamespace.nr_tracks = 100 

# when the page is loaded call the rails controller to fetch a list of recordings
digiWhamsNamespace.loadWhams = ->
  if ($('#digiWhams')[0])
    $.getScript("/api/digi_wham_resources" )

# when a play button is pressed reset all buttons    
digiWhamsNamespace.reset_play_buttons = () ->
  $('.play').each (index, element) =>
    id = $(element).attr('id')
    $('#' + id  + '.play').css("display", 'block')
    $('#' + id  + '.loading').css("display", 'none')
    $('#' + id  + '.pause').css("display", 'none')
    
# when a play button is pressed reset all buttons    
digiWhamsNamespace.build_audio_channel = (id) ->
  console.log id

# expand the comments frame on a track
digiWhamsNamespace.show_comments = (comment_id) ->
  digiWhamsNamespace.hide_comments()
  
    
  if $('#'+comment_id+'.comments').is(":hidden")
    $('#'+comment_id+'.comments').slideDown(400)
  else
    $('#'+comment_id+'.comments').slideUp(400)
  
digiWhamsNamespace.hide_comments =() ->
  $('.comments').each (index, element) =>
    $(element).slideUp(400)
  
# pick up mouse clicks on the play button    
digiWhamsNamespace.connect_play_button =() ->
  
  $('.play').on 'click', ->
    digiWhamsNamespace.reset_play_buttons()
    id = $(this).attr 'id'
    $('#'+ id + '.play').css("display", 'none')
    $('#'+ id + '.loading').css("display", 'block')
    $('#'+ id + '.stop').css("display", 'none')
    
     
  
  # Set all players to default  
  $('.loading').click =>
    digiWhamsNamespace.reset_play_buttons()
  
  $('.pause').on 'click', ->
    alert $(this).attr 'id'
    
  $('.add_to_playlist').on 'click', ->
    alert $(this).attr 'id' 
    
  $('.like').on 'click', ->
    alert $(this).attr 'id' 
    
  $('.share').on 'click', ->
    alert $(this).attr 'id' 
    
  $('.comment').on 'click', ->
    digiWhamsNamespace.show_comments( $(this).attr 'id' )
    

  $('.audio-waveform').on "click", (event) ->
    waveform_width  = $(this).width()
    offset          = $(this).offset()
    mouse_pos_x     = event.pageX - offset.left    
    id              =    $(this).attr 'id'    
    $("#"+id+".playhead").css("margin-left": 100);
    
    #alert mouse_pos_x / waveform_width  




# public function called when all players are loaded    

@initialize_digiwham =  ->

  $('.digi-wham').each (index, element) =>
    digiWhamsNamespace.build_audio_channel( $(element).attr('id') ) 
    console.log $(element).attr('mp3')
  
  
  digiWhamsNamespace.connect_play_button()
  
    


  


  
  
    
    
