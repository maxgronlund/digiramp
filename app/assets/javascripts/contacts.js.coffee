# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  
  
        
    
  endless_contacts()
  

  $(".add-selected").click ->
    #console.log $( "input:checkbox:checked" ).val()
    user_id = $(this).attr 'id'
    contact_group_id  = $(this).attr 'contact_group_id'
    console.log contact_group_id
    $(":checkbox:checked").each ->
      contact_id = $(this).val()

      $.getScript("add_contacts/new?contact_id=" + contact_id)

  
  $(".select-all").click ->
    $.getScript("toggle_selection")
    
    $(":checkbox").each ->
      @checked = not @checked
  
      return
      
  $("#client_import_file").change ->
    #alert 'fo'
    if $("#client_import_file").val() == ''
      $(".btn-save").attr('disabled', 'disabled');
    else
      $(".btn-save").removeAttr("disabled")
      
      
   


  
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