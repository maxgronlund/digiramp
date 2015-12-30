require 'uri'


class StakeMailer < ApplicationMailer
  
  # is a stake is send to an email of a user not signed up 
  # an email is send
  
  def notify_unknown_stakeholder stake_id
    #stake                  = Stake.cached_find(stake_id)
    ##blog                   = Blog.cached_find('Support')
    ##blog_post              = BlogPost.cached_find( "RESET EMAIL" , blog )
    ##title                  = blog_post.title
    ##body                   = blog_post.body                    
    ##reset_url              = url_for( controller: 'password_resets', action: 'edit', id: user.password_reset_token)
    #
    #merge_vars = 
    #[ 
    #  { rcpt: stake.email,
    #    vars: 
    #    [ 
    #      { title:      "You have received a payment",         
    #        content:    'Please click on the link below to start collecting money from DigiRAMP',
    #        email:      "Please click on the link below to start collecting money from DigiRAMP"
    #      }
    #    ]
    #  }
    #]
    #
    #send_with_mandrill
    #( 
    #  [
    #      {
    #        email: stake.email, name: 'Unknown stakeholder' 
    #      }
    #  ], 
    #  "notify-unknown-stakeholder", 
    #  'You have received a payment on DigiRAMP', 
    #  ["stakeholder"], 
    #  merge_vars,
    #  true,
    #  true,
    #  "12-digiramp-stakeholder",
    #  "handlebars" 
    #)
  end
  

end


