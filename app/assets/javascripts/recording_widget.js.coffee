# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  

  if $('.recording_widget').length
    $("input:text").focus ->
      $(this).select()  
    


  
$(document).ready(ready)
$(document).on('page:load', ready)
#
#  $(document).ready(function() {
#      $("input:text").focus(function() { $(this).select(); } );
#  });