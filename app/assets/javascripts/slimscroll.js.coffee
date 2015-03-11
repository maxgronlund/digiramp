ready = ->
  $('.rec-comments').slimScroll height: 'auto' 
  resize_user_profile_comments()
  $(window).resize ->
    resize_user_profile_comments()
  
$(document).ready(ready)
$(document).on('page:load', ready)


resize_user_profile_comments =() ->
  
  height = $( window ).height() - 280 
  $('.rec-comments').height(height)
  
