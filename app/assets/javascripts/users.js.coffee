ready = ->

  endless_users()
  $(window).resize ->
    endless_users()

$(document).ready(ready)
$(document).on('page:load', ready)








@endless_users =() ->
  
  if $('.endless-users').length
    if $('.pagination').length
      #console.log 'endless users'
      $(window).scroll ->
        url = $('.pagination .next a').attr('href')
        if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 400
          $('.pagination').text('...')
          $.getScript(url)
      $(window).scroll()
