class OpportunityEvaluationMailer < ApplicationMailer
 
  def invite user_id, opportunity_evaluation_id
    
    opportunity_evaluation        = OpportunityEvaluation.cached_find(opportunity_evaluation_id)
    user                          = User.cached_find(user_id)
    email                         = user.email
    sender                        = User.cached_find(opportunity_evaluation.user_id)
    
    link                          = url_for( controller: 'opportunity/opportunities', 
                                             action: 'show', 
                                             id: opportunity_evaluation.opportunity_id, 
                                             opportunity_invitation: 'true', 
                                             user_id: user.id)
                                             
    #fotter_link                   = url_for( controller: 'contacts', 
    #                                        action: 'new')
    
    subject = opportunity_evaluation.subject
    title   = opportunity_evaluation.subject
    body    = opportunity_evaluation.body
    
    begin
      template_name = "opportunity-evaluation-for-new-user"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["opportunity", "invitation", "invite-to-account"],
        track_clicks: true,
        track_opens: true,
        subaccount: sender.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {opportunity_evaluation_id: opportunity_evaluation.id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: title},
                   {name: "BODY",        content: body },
                   {name: "LINK",        content: link }
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end
  
  def invite_to_account user_id, opportunity_evaluation_id
    user                          = User.cached_find(user_id)
    email                         = user.email
    opportunity_evaluation        = OpportunityEvaluation.cached_find(opportunity_evaluation_id)
    sender                        = User.cached_find(opportunity_evaluation.user_id)
    
    link                          = url_for( controller: 'opportunity/opportunities', 
                                             action: 'show', 
                                             id: opportunity_evaluation.opportunity_id, 
                                             opportunity_invitation: 'true', 
                                             user_id: user.id)
                                             
    #fotter_link                   = url_for( controller: 'contacts', 
    #                                        action: 'new')
    
    subject = opportunity_evaluation.subject
    title   = opportunity_evaluation.subject
    body    = opportunity_evaluation.body
    
    begin
      template_name = "opportunity-evaluation-for-new-user"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["opportunity", "invitation", "invite-to-account"],
        track_clicks: true,
        track_opens: true,
        subaccount: sender.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {opportunity_evaluation_id: opportunity_evaluation.id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: title},
                   {name: "BODY",        content: body },
                   {name: "LINK",        content: link }
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

# OpportunityEvaluationMailer.delay.invite_to_account