
ready = ->

  $('#common_work_ipis').on 'cocoon:after-insert' , (e, insertedItem)->
    bind_share_fields()
    calculate_sum()
  $('#common_work_ipis').on 'cocoon:after-remove' , (e, insertedItem)->
    bind_share_fields()
    calculate_sum() 
  
  bind_share_fields()
  calculate_sum()


$(document).ready(ready)
$(document).on('page:load', ready)







@bind_share_fields = () ->
  
  total_sum = 0
  
  $("input").focus ->
    $( this ).change -> 
      calculate_sum()
    $( this ).keyup -> 
      calculate_sum()

  
      



calculate_sum = () ->
  
  total_sum = 0
  $('.work_ip_share').find('input').each ->
    total_sum += parseFloat $( this ).val()


  $( ".total_share" ).text( total_sum )
  
  if total_sum != 100
    $( ".total_share" ).css( "color", "red" , "border")
    $( ".total_share" ).css('border-color', '#fcc')
  else
    $( ".total_share" ).css( "color", "black" );
    $( ".total_share" ).css('border-color', '#ccc')
    


    
    
    