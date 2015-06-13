class MandrillAccountService
  
  def self.create_account_for_user user
    return unless user.mandrill_account_id.blank?
    begin
      mandril_client              = Mandrill::API.new Rails.application.secrets.email_provider_password
      mandrill_account_id         = "cus-" + user.id.to_s
                                  
      name                        = mandrill_account_id
      notes                       = "Free social account, signed up on " + user.created_at.to_formatted_s(:short)
      custom_quota                = 1200
      result                      = mandril_client.subaccounts.add mandrill_account_id, name, notes, custom_quota
      user.mandrill_account_id    = mandrill_account_id
      user.save(validate: false)
      
      ap mandrill_account_id
  
    rescue Mandrill::Error => e
      ap "A mandrill error occurred: #{e.class} - #{e.message}"
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end
  
end
#MandrillAccountService.create_for_user User.last