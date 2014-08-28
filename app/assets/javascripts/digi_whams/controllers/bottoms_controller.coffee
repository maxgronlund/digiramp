class @BottomsController
  constructor: ->

    $('.add_to_playlist').on 'click', ->
      show_playlists( $(this).attr 'id' )
    
    $('.like').on 'click', ->
      id = $(this).attr 'id' 
      # count playbacks
      $.getScript("/digiwham/likes/" + id)

    
    $('.share').on 'click', ->
      alert $(this).attr 'id' 
    
    $('.comment').on 'click', ->
      show_comments( $(this).attr 'id' )
      
    $('.top-pane').on 'click', ->
      close_bottom_panes()
      id = $(this).attr 'id'
      reset_buttom_buttons(id)

        
      
    #$(window).resize ->
    #  if $( window ).width() > 474
    #     $('.digi-wham-buttons').each (index, element) =>
    #       $('#' + id  + '.digi-wham-buttons').css( "display": 'block' );
    #  else
    #    $('#' + id  + '.digi-wham-buttons').css( "display": 'hidden' );
    
      
  # expand the comments frame on a track
  show_playlists = (recording_id) ->
    close_bottom_panes()
  
    if $('#'+recording_id+'.playlists').is(":hidden")
      $('#'+recording_id+'.playlists').slideDown(400)
    else
      $('#'+recording_id+'.playlists').slideUp(400)
  
  # expand the comments frame on a track
  show_comments = (recording_id) ->
    close_bottom_panes()
  
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
  
  # close all bottom frames  
  close_bottom_panes =() ->    
    hide_comments()
    hide_playlists()

  # close all buttom panes but the selected
  reset_buttom_buttons = (selected_id) ->
    $('.digi-wham-buttons').each (index, element) =>
      id = $(element).attr('id')
      if id is selected_id 
         open_buttom_buttons(id)
      else
        close_buttom_buttons(id)
          
  close_buttom_buttons = (id) ->
    $('#' + id  + '.digi-wham-buttons').slideUp(400)
          
  open_buttom_buttons = (id) ->
    $('#' + id  + '.digi-wham-buttons').slideDown(400)