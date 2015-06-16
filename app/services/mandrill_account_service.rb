class MandrillAccountService
  
  def self.create_account_for_user user_id
    user    = User.cached_find(user_id)
    return unless user.mandrill_account_id.blank?
    begin
      
      mandril_client              = Mandrill::API.new Rails.application.secrets.email_provider_password                       
      mandrill_account_id         = "cus-" + user.id.to_s 
      notes                       = "Free social account, signed up on " + user.created_at.to_formatted_s(:short)
      custom_quota                = 45
      #result                      = mandril_client.subaccounts.add mandrill_account_id, name, notes, custom_quota
      user.mandrill_account_id    = mandrill_account_id
      user.save(validate: false)
      #ap result
    rescue Mandrill::Error => e
      ap "A mandrill error occurred: #{e.class} - #{e.message}"
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end
  
  def self.update_account_quota_for_user user_id
    
    begin
        user                        = User.cached_find(user_id)
        mandril_client              = Mandrill::API.new Rails.application.secrets.email_provider_password
        id                          = user.mandrill_account_id
        custom_quota                = 45
        result = mandril_client.subaccounts.update id, nil, nil, custom_quota
        ap result
    
    rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        
        user.mandrill_account_id = nil
        user.save(validate: false)   
        create_account_for_user user_id

    end
  end
  
  private 
  
  def self.get_mandrill_id_for_the user
    
    user.mandrill_account_id = "cus-" + user.id.to_s 
    user.save(validate: false)
    
  end
  
end
# MandrillAccountService.create_for_user User.last.id

# MandrillAccountService.update_account_quota_for_user User.first.id