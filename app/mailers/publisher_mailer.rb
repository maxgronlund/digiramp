class PublisherMailer < ApplicationMailer
  
 

  def send_notification ipi_publisher_id
    ap '------------------ send_notification --------------------------'
    ap ipi_publisher_id
    ipi_publisher = IpiPublisher.cached_find(ipi_publisher_id)
    link              = url_for( controller: "user/confirm_common_work_ipis", action: 'edit', user_id: common_work_ipi.user.slug, id: common_work_ipi.uuid )
    
    
    #confirmation_url = url_for( controller: 'confirmation/publishers', action: 'show', id: publisher.transfer_uuid )
    #
    #
    #
    #merge_vars   = [ { rcpt: publisher.email,
    #                    vars: [ {name: "title",                   content: 'fo'},
    #                            {name: "body",                    content: 'bar'},
    #                            {name: "confirmation_url",        content: confirmation_url}
    #                            #{name: "ACCEPT_URL",    content: accept_url}
    #                          ]
    #                  }
    #                ]
    #  if user = publisher.user
    #    send_with_mandrill( [{email: publisher.email, name: publisher.legal_name }], 
    #                        "publishing-confirmation-request", 
    #                        'Please confirm your publishing rights', 
    #                        ["publishing", "confirmation"], 
    #                        merge_vars,
    #                        true,
    #                        true,
    #                        user.mandrill_account_id,
    #                        "handlebars" 
    #                       )
    #end
  end
  
  
  def send_invitation ipi_publisher_id
    ap '--------------------- send_notification --------------------------------'
    ap ipi_publisher_id
    #return unless common_work_ipi   = CommonWorkIpi.cached_find(common_work_ipi_id)
    
    #link = url_for(controller: "user/accept_creations/#{common_work_ipi.uuid}")
    #user/accept_creations/8d5cd840-76a4-11e5-a707-60334bfffe81
    
  end

end
