#-----------------------------------------------
# pusher
#-----------------------------------------------

channel = 'digiramp_radio_' + current_user.email
Pusher.trigger(channel, 'digiramp_event', {"title" => 'User already a member', 
                                      "message" => "#{params[:account_user][:email]} is already added", 
                                      "time"    => '15000', 
                                      "sticky"  => 'false', 
                                      "image"   => 'notice'
                                      })

#-----------------------------------------------
# stupid email validation
#-----------------------------------------------
# elsif /^\S+@\S+\.\S+$/.match(params[:account_user][:email]).nil?
  
# usage
# EmailValidator.validate email