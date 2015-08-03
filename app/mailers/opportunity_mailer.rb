class OpportunityMailer < ApplicationMailer
  #default from: "noreply@digiramp.com"


  def invite email, opportunity_invitation_id, user_id
   
    if user                       = User.cached_find(user_id)
      if opportunity_invitation   = OpportunityInvitation.cached_find(opportunity_invitation_id)
        if opportunity            = opportunity_invitation.opportunity
          blog                    = Blog.cached_find('Support')
          blog_post               = BlogPost.cached_find( "INVITE TO OPPORTUNITY" , blog )
          opportunity_link        = url_for( controller: 'opportunity/opportunities', action: 'show', id: opportunity.id, opportunity_invitation: 'true', user_id: user_id)
          fotter_link             = url_for( controller: 'contacts', action: 'new')
        end
      end
    end
    
  
    if opportunity
      begin
        template_name = "opportunity-invitation"
        template_content = []
        message = {
          to: [{email: email , name: user.user_name }],
          from: {email: "noreply@digiramp.com"},
          subject: opportunity_invitation.title,
          tags: ["opportunity", "invitation"],
          track_clicks: true,
          track_opens: true,
          subaccount: user.mandrill_account_id,
          recipient_metadata: [{rcpt: email, values: {message_id: opportunity_invitation_id}}],
          merge_vars: [
            {
             rcpt: email,
             vars: [
                     {name: "BLOG_POST_TITLE",       content: blog_post.title},
                     {name: "BLOG_POST_BODY",        content: blog_post.body},
                     {name: "TITLE",                 content: opportunity_invitation.title},
                     {name: "BODY",                  content: opportunity_invitation.body},
                     {name: "OPPORTUNITY_LINK",      content: opportunity_link},
                     {name: "FOOTER_LINK",           content: fotter_link}
                     ]
            }
          ]
        }
        mandril_client.messages.send_template template_name, template_content, message
       rescue Mandrill::Error => e
        Opbeat.capture_message("#{e.class} - #{e.message}")
      end
    end
  end
  
  def invite_to_account email, opportunity_invitation_id, user_id

    return unless user                    = User.cached_find(user_id)
    return unless opportunity_invitation  = OpportunityInvitation.cached_find(opportunity_invitation_id)
    return unless opportunity             = opportunity_invitation.opportunity
    return unless blog                    = Blog.cached_find('Support')
    return unless blog_post               = BlogPost.cached_find( "INVITE TO OPPORTUNITY" , blog )
    
    opportunity_link        = url_for( controller: 'activate_account', 
                                       action: 'edit', 
                                       id: user.password_reset_token, 
                                       opportunity_id: opportunity.id  )
                                       
    fotter_link             = url_for( controller: 'contacts', action: 'new')
    
    begin
      template_name = "opportunity-invitation"
      template_content = []
      message = {
        to: [{email: email , name: user.user_name }],
        from: {email: "noreply@digiramp.com"},
        subject: opportunity_invitation.title,
        tags: ["opportunity", "invitation"],
        track_clicks: true,
        track_opens: true,
        subaccount: user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {opportunity_invitation_id: opportunity_invitation.id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "BLOG_POST_TITLE",       content: blog_post.title},
                   {name: "BLOG_POST_BODY",        content: blog_post.body},
                   {name: "TITLE",                 content: opportunity_invitation.title},
                   {name: "BODY",                  content: opportunity_invitation.body},
                   {name: "OPPORTUNITY_LINK",      content: opportunity_link},
                   {name: "FOOTER_LINK",           content: fotter_link}
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end

end
