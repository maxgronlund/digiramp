class UserMailer < ApplicationMailer
  
  def password_reset user_id
    user                   = User.cached_find(user_id)
    blog                   = Blog.cached_find('Support')
    blog_post              = BlogPost.cached_find( "RESET EMAIL" , blog )
    title                  = blog_post.title
    body                   = blog_post.body                    
    reset_url              = url_for( controller: 'password_resets', action: 'edit', id: user.password_reset_token)

    merge_vars = [ { rcpt: user.email,
                      vars: [ {name: "TITLE",         content: title},
                              {name: "BODY",          content: body},
                              {name: "RESET_URL",    content: reset_url}
                            ]
                    }
                  ]
 
    send_with_mandrill( [{email: user.email, name: user.user_name }], 
                        "password-reset", 
                        'Password reset from DigiRAMP', 
                        ["reset-password"], 
                        merge_vars,
                        false,
                        false,
                        "02-digiramp-password-reset",
                        "mailchimp" )
  end

  def invite_new_user_to_account user_id, title, body
     user         = User.cached_find(user_id)
     accept_url   = url_for( controller: 'accept_invitations', action: 'edit', id: user.password_reset_token)
     merge_vars   = [ { rcpt: user.email,
                         vars: [ {name: "TITLE",         content: title},
                                 {name: "BODY",          content: body},
                                 {name: "ACCEPT_URL",    content: accept_url}
                               ]
                       }
                     ]
 
     send_with_mandrill( [{email: user.email, name: user.user_name }], 
                         "invite-new-user-to-account", 
                         'You have been invitet to a DigiRAMP account', 
                         ["account_invitation", "new_user"], 
                         merge_vars,
                         true,
                         true,
                         user.mandrill_account_id,
                         "mailchimp" 
                        )
  end
  
  def invite_existing_user_to_account  user_id, title, body
    user         = User.cached_find(user_id)
    
    merge_vars   = [ { rcpt: user.email,
                        vars: [ {name: "TITLE",         content: title},
                                {name: "BODY",          content: body}
                              ]
                      }
                    ]

    send_with_mandrill( [{email: user.email, name: user.user_name }], 
                        "invite-existing-user-to-account", 
                        'You have been invitet to a DigiRAMP account', 
                        ["account_invitation", "existing_user"], 
                        merge_vars,
                        true,
                        true,
                        user.mandrill_account_id,
                        "mailchimp"
                      )
  end
  
  def invite_user_to_catalog( email, 
                              title, 
                              body, 
                              invited_user_id, 
                              account_id, 
                              catalog_id, 
                              user_exists
                              )
                              
    blog        = Blog.cached_find('Support')
    blog_post   = BlogPost.cached_find( "INVITE TO CATALOG" , blog )
    account     = Account.cached_find(account_id)
    inviter     = account.user
    if user_exists
      invitation_link  = url_for( controller: 'catalog/catalogs', 
                                       action: 'show', 
                                   account_id: account_id, 
                                           id: catalog_id)
    else 
      user             = User.cached_find(invited_user_id)               
      invitation_link  = url_for( controller: 'activate_catalog_user', 
                                       action: 'edit', 
                                           id: user.password_reset_token, 
                                   catalog_id: catalog_id
                                 )
    end
    fotter_link             = url_for( controller: 'contacts', action: 'new')
    
    merge_vars   = [ { rcpt: email,
                        vars: [ {name: "TITLE",             content: title},
                                {name: "BODY",              content: body},
                                {name: "BLOG_POST_TITLE",   content: blog_post.title},
                                {name: "BLOG_POST_BODY",    content: blog_post.body},
                                {name: "INVITATION_LINK",   content: invitation_link},
                                {name: "FOOTER_LINK",       content: fotter_link}
                              ]
                      }
                    ]
    
    send_with_mandrill( [{email: email }], 
                        "invite-user-to-catalog", 
                        title, 
                        ["catalog_invitation"], 
                        merge_vars,
                        true,
                        true,
                        inviter.mandrill_account_id,
                        "mailchimp" 
                      )
  end
  
  def confirm_signup user_id
    
    user                        = User.cached_find(user_id)
    confirmation_token          = UUIDTools::UUID.timestamp_create().to_s
    user.update_columns(
      confirmation_sent_at:  Time.now,
      confirmation_token:    confirmation_token
    )
    confirmation_link  = url_for( controller: '/signup_confirmations', 
                                     action: 'edit', 
                                         id: confirmation_token)
    
    #ap confirmation_link
    merge_vars   = [ { rcpt: user.email,
                        vars: [ {name: "LINK", content: confirmation_link} ]
                      }
                    ]
    
    send_with_mandrill( [{email: user.email }], 
                        "account-confirmation", 
                        'Welcome to DigiRAMP', 
                        ["account_confirmation"], 
                        merge_vars,
                        true,
                        true,
                        '10-digiramp-account-confirmation',
                        "mailchimp" 
                      )
    
    
    
  end
  
  def say_what_you_want user_id
    user                        = User.cached_find(user_id)

    confirmation_link  = url_for( controller: "/user/user_configurations", action: 'edit', user_id: user.slug, id: user.user_configuration.id)
    
    
    merge_vars   = [ { rcpt: user.email,
                        vars: [ {name: "LINK", content: confirmation_link} ]
                      }
                    ]
    
    if Rails.env.production?
      send_with_mandrill( [{email: user.email }], 
                          "say-what-you-want", 
                          'Opporunities on DigiRAMP', 
                          ["nudging"], 
                          merge_vars,
                          true,
                          true,
                          '11-digiramp-nudging',
                          "mailchimp" 
                        )
    else
      ap confirmation_link
    end
  end
  
end
