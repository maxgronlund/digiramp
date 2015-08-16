class PublisherMailer < ApplicationMailer
  
 

  def request_confirmation_from_existing_user publisher
    ap 'request_confirmation_from_existing_user'
    
    
    confirmation_url = url_for( controller: 'confirmation/publishers', action: 'show', id: publisher.transfer_uuid )
    
    
    
    merge_vars   = [ { rcpt: publisher.email,
                        vars: [ {name: "title",                   content: 'fo'},
                                {name: "body",                    content: 'bar'},
                                {name: "confirmation_url",        content: confirmation_url}
                                #{name: "ACCEPT_URL",    content: accept_url}
                              ]
                      }
                    ]
      if user = publisher.user
        send_with_mandrill( [{email: publisher.email, name: publisher.legal_name }], 
                            "publishing-confirmation-request", 
                            'Please confirm your publishing rights', 
                            ["publishing", "confirmation"], 
                            merge_vars,
                            true,
                            true,
                            user.mandrill_account_id,
                            "handlebars" 
                           )
    end
  end

end
