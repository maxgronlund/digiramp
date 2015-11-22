class NudgeMailer < ApplicationMailer
  
 
  
  def invite_friends
    
    if user_confirgurations = UserConfiguration.where(
        i_want_to_promote_my_music: true, 
        has_invited_friends: false
      )
    
      user_confirgurations.find_each do |user_configuration|
        if user                        = user_configuration.user
        
          invite_friends_link  = url_for( controller: "user/invite_friends", action: 'new', user_id: user.slug)
          
          
          merge_vars   = [ { rcpt: user.email,
                              vars: [ {name: "LINK", content: invite_friends_link} ]
                            }
                          ]
          
          if Rails.env.production?
            send_with_mandrill( [{email: user.email }], 
                                "invite-friends", 
                                'Improve your network on DigiRAMP', 
                                ["nudging"], 
                                merge_vars,
                                true,
                                true,
                                '11-digiramp-nudging',
                                "mailchimp" 
                              )
          else
            ap invite_friends_link
          end
        end
      end
    end
  end
  
  def invite_one_friend user_id
    
    if user                        = User.cached_find(user_id)
    
      invite_friends_link  = url_for( controller: "user/invite_friends", action: 'new', user_id: user.slug)
      merge_vars   = [ { rcpt: user.email,
                          vars: [ {name: "LINK", content: invite_friends_link} ]
                        }
                      ]
      

        send_with_mandrill( [{email: user.email }], 
                            "invite-friends", 
                            'Improve your network on DigiRAMP', 
                            ["nudging"], 
                            merge_vars,
                            true,
                            true,
                            '11-digiramp-nudging',
                            "mailchimp" 
                          )
    end
  end
end

# NudgeMailer.invite_one_friend User.first