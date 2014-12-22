# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#ready = ->
#  
#  
#
#  $("#message_title").change ->
#    enable_send_button()
#
#
#  
#$(document).ready(ready)
#$(document).on('page:load', ready)


@update_count = () ->
  $.getScript("/message_counts/1");  
  
  

@enable_send_button =() ->
  
  if $("#message_title").val() != ''
    $(".btn-send").removeAttr("disabled")
  else
    $(".btn-send").attr('disabled', 'disabled');

@check_message_title =() ->
  $("#message_title").keyup ->
    enable_send_button()