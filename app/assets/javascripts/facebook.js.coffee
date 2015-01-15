#https://developers.facebook.com/docs/javascript/howto/jquery

ready = ->
  
  $('body').prepend('<div id="fb-root"></div>')

  $("#login_with_facebook").click ->
    FB.getLoginStatus (response) ->
      if response.status is "connected"
        console.log "Logged in."
        console.log(response.authResponse.accessToken)
        
      else
        FB.login (response) ->
          window.location = '/auth/facebook/callback' if response.authResponse
          scope: "publish_actions"
      return
    
    
    
   
   
   
   
   
   #FB.login (->
   #  FB.api "/me/feed", "post",
   #    message: "Hello, world!"
   #  return
   #),
   #  scope: "publish_actions"

  #$.ajax
  #  url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
  #  dataType: 'script'
  #  cache: true


$(document).ready(ready)
$(document).on('page:load', ready)


