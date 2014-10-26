ready = ->
  
  $('#remove_meta').remove();
  
  title = $('#og_title').data('title')
  if title? 
    $('head').append('<meta property="og:title" content="' + title +  '" id="remove_meta"/>' );
    
  og_type= $('#og_type').data('og_type')
  if title? 
    $('head').append('<meta property="og:type" content="' + og_type +  '" id="remove_meta"/>' );
    
  og_url= $('#og_url').data('og_url')
  if title? 
    $('head').append('<meta property="og:url" content="' + og_url +  '" id="remove_meta"/>' );
    
  og_image= $('#og_image').data('og_image')
  if title? 
    $('head').append('<meta property="og:image" content="' + og_image +  '" id="remove_meta"/>' );
 
  
        
    

  
$(document).ready(ready)
$(document).on('page:load', ready)