ready = ->
  
  if $('.digiramp_player')[0]
    soundManager = recreateSoundManager()
    

  $('#playlist_recording_ids').chosen()
  
  
  
  if $('.endless-pages').length
    if $('.pagination').length
      $(window).scroll ->
        url = $('.pagination .next a').attr('href')
        if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 200
    
          $('.pagination').text('Fetching more songs...')
          $.getScript(url)
      $(window).scroll()
        
    

  
$(document).ready(ready)
$(document).on('page:load', ready)
