







ready = ->
  console.log('----------------------------------')
  console.log('readdy')
  
  
  soundManager.setup()
  
  
  
  #console.log( square(5) )
 
  console.log('----------------------------------')
$(document).ready(ready)
$(document).on('page:load', ready)



square = (x) -> x * x



