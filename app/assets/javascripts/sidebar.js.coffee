ready = ->
  
  $("#menu-toggle").click (e)->
    e.preventDefault()
    $("#wrapper").toggleClass("toggled")
    
    if $("#wrapper").hasClass( "toggled" )
      $('.fa-angle-double-right').css  {'display': 'none'  }
      $('.fa-angle-double-left').css   {'display': 'inline'}
    else
      $('.fa-angle-double-right').css  {'display': 'inline'}
      $('.fa-angle-double-left').css   {'display': 'none'  }
    
  #$("#sidebar-toggle").click (e)->
  #  e.preventDefault()
  #  $("#wrapper").toggleClass("toggled")
  #  
    
  $( window ).resize ->
    if $(window).width() > 753
      $('#wrapper').toggleClass("toggled", false)
      #$('.fa-angle-double-right').css  {'display': 'none'}
      #$('.fa-angle-double-left').css   {'display': 'none'}
      $('.btn-sidemenu').css           {'display': 'none'}
    else
      #$('.fa-angle-double-right').css  {'display': 'inline'}
      #$('.fa-angle-double-left').css   {'display': 'none'  }
      $('.btn-sidemenu').css           {'display': 'inline'}
  
  
  if $(window).width() > 753
    $('.btn-sidemenu').css          {'display': 'none'}
  else
    $('.btn-sidemenu').css          {'display': 'inline'}  

  
$(document).ready(ready)
$(document).on('page:load', ready)