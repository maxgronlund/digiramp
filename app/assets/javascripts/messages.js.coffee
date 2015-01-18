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
  
  

@enable_send_button =(id) ->

  if $("#title_" + id ).val() != ''
    $(".btn_" + id ).removeAttr("disabled")
  else
    $(".btn_" + id ).attr('disabled', 'disabled');

@check_message_title =(id) ->

  $("#title_" + id).keyup ->
    enable_send_button(id)
  

  $("#body_" + id).keyup ->
    enable_send_button(id)
