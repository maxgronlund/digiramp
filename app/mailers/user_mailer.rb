class UserMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  def password_reset user_id
    @user        = User.cached_find(user_id)
   
    
    blog            = Blog.cached_find('Support')
    blog_post       = BlogPost.cached_find( "RESET EMAIL" , blog )
    @reset_link     = url_for( controller: 'password_resets', action: 'edit', id: @user.password_reset_token)
    @title          = blog_post.title
    @body           = blog_post.body
    @fotter_link    = url_for( controller: 'contacts', action: 'new')

    mail to: @user.email, subject: blog_post.title
  end
  
  def invite_new_user_to_account user_id, title, body
     @user         = User.cached_find(user_id)
     @body         = body
     
     
     mail to: @user.email,  subject: title
  end
  
  def invite_existing_user_to_account user_id, account_id, invitation, current_user_id
    @user = User.cached_find(user_id)
    
    mail to: @user.email, subject: "You are invited to an account on DigiRAMP"
    
    
    
    #current_user = User.cached_find(current_user_id)
    #channel = 'digiramp_radio_' + current_user.email
    #Pusher.trigger(channel, 'digiramp_event', {"title" => 'EMAIL SEND', 
    #                                      "message" => "An invitation is send to #{@user.email}", 
    #                                      "time"    => '15000', 
    #                                      "sticky"  => 'false', 
    #                                      "image"   => 'notice'
    #                                      })
  end
  

  
  
  def invite_user_to_catalog( email, 
                              title, 
                              body, 
                              current_user_id, 
                              invited_user_id, 
                              account_id, 
                              catalog_id, 
                              user_exists
                              )

    
    @title      = title
    @body       = body
    
    
    blog        = Blog.cached_find('Support')
    @blog_post  = BlogPost.cached_find( "INVITE TO CATALOG" , blog )
    

    

    if user_exists
      @invitation_link  = url_for( controller: 'catalog/catalogs', 
                                       action: 'show', 
                                   account_id: account_id, 
                                           id: catalog_id)
    else 
      user = User.cached_find(invited_user_id)               
      @invitation_link  = url_for( controller: 'activate_catalog_user', 
                                       action: 'edit', 
                                           id: user.password_reset_token, 
                                   catalog_id: catalog_id
                                 )
    end
    @fotter_link             = url_for( controller: 'contacts', action: 'new')
    
    log_activity( email,
                  'Catalog Invitation', 
                  current_user_id, 
                  invited_user_id, 
                  account_id, 
                  catalog_id 
                )

    mail to: email, subject: @title
    
  end
  


  # add the invitaion to the log
  def log_activity( email, email_type, current_user_id, invited_user_id, account_id, catalog_id )
   
    current_user = User.cached_find(current_user_id)
    recipient    = User.cached_find(invited_user_id)
    # create an email to store in the db               
    mail = Email.create(
                                  email: email,
                                user_id: current_user_id,
                        send_to_user_id: invited_user_id,
                             account_id: account_id,
                           content_type: 'Invitation to Catalog',
                                content: {title: @title, body: @body}
                        )
    

    mail.create_activity(:created, 
                             owner: current_user,
                         recipient: recipient,
                    recipient_type: recipient.class.name,
                        account_id: account_id,
                                   params: { title: @title,
                                              body: @body,
                             invited_to_catalog_id: catalog_id
                                            }
                          ) 
  end


end
