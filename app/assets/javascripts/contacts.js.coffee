# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  
  
        
    
  endless_contacts()
  
  $(".select-all").click ->
    user_id = $(this).attr 'id'
    #alert user_id
    #/user/users/:user_id/contacts/:contact_id/toggle_selection
    $.getScript("/user/users/#{user_id}/contacts/0/toggle_selection"    )
    #$.getScript(url)
    $(":checkbox").each ->
      @checked = not @checked
      
      
      
      return
  


  
$(document).ready(ready)
$(document).on('page:load', ready)







@endless_contacts =() ->
  
  if $('.endless-contacts').length
    if $('.pagination').length
      $(window).scroll ->
        url = $('.pagination .next a').attr('href')

        if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 200
          $('.pagination').text('...')
          $.getScript(url)
      $(window).scroll()