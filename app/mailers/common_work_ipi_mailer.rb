#CommonWorkIpiMailer.send_notification common_work_ipi_id

# This class validates sends an email to a user or invites a user to DIgiRAMP when an common_work_ipi is created or updated. 
# ==== Example
#  CommonWorkIpiMailer.send_notification common_work_ipi_id


class CommonWorkIpiMailer < ApplicationMailer


  def send_notification common_work_ipi_id, from_user_id

    common_work_ipi   = CommonWorkIpi.cached_find(common_work_ipi_id)
    return unless common_work_ipi.user
    email             = common_work_ipi.email
    link              = url_for( controller: "user/confirm_common_work_ipis", action: 'edit', user_id: common_work_ipi.user.slug, id: common_work_ipi.uuid )
                      
    common_work       = common_work_ipi.common_work
    user              = common_work_ipi.user
    from_user         = User.cached_find(from_user_id)
    subject           = "#{from_user.get_full_name} has mentioned you as a creator on DigiRAMP"


    begin
      template_name = "ipi-confirmation"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["ipi", "confirmation", "common-work"],
        track_clicks: true,
        track_opens: true,
        subaccount: from_user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {common_work_ipi: common_work_ipi}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: "Please claim your rights"},
                   {name: "BODY",        content: "Click the link belove and recevie reconition, and revenue from sales and mechanical licenses if it's you production agreement" },
                   {name: "LINK",        content: link }
                  ]
          }
        ]
      }
    rescue => e
      ErrorNotification.post "CommonWorkIpiMailer #{e.inspect}"
    end  
    
    begin
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      ErrorNotification.post "CommonWorkIpiMailer#Mandrill - #{e.message}"
    end
  end
  
  def send_invitation common_work_ipi_id, from_user_id
    return unless common_work_ipi   = CommonWorkIpi.cached_find(common_work_ipi_id) rescue false
    return unless user              = common_work_ipi.user
    return unless common_work       = common_work_ipi.common_work
    return unless email             = common_work_ipi.email 
    return unless common_work_user  = common_work.user
    from_user                       = User.cached_find(from_user_id)
    subject                         = "#{from_user.get_full_name} has mentioned you as a creator on DigiRAMP"
    
    link = url_for( controller: "user/confirm_common_work_ipis", action: 'edit', user_id: common_work_ipi.user.slug, id: common_work_ipi.uuid )
    
    begin
      template_name = "ipi-confirmation"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["ipi", "confirmation", "common-work"],
        track_clicks: true,
        track_opens: true,
        subaccount: from_user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {common_work_ipi: common_work_ipi}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: "Please claim your rights"},
                   {name: "BODY",        content: "Click the link belove and recevie reconition, and revenue from sales and mechanical licenses if it's you production agreement" },
                   {name: "LINK",        content: link }
                  ]
          }
        ]
      }
    rescue => e
      ErrorNotification.post "CommonWorkIpiMailer #{e.inspect}"
    end  
      
    begin
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      ErrorNotification.post "CommonWorkIpiMailer#Mandrill - #{e.message}"
    end

  end

  
end


# IpiMailer.delay.common_work_ipi_confirmation_email