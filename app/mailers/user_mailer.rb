class UserMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  def password_reset user
    @user           = user
    @message        = MailMessage.password_reset
    mail to: @user.email, subject: "reset password"
  end
  
  def invite_new_user_to_account user_id, title, body
     @user         = User.cached_find(user_id)
     @body         = body
     #puts '-----------------------------------------------------------------------------'
     #puts 'invite_new_user_to_account'
     #puts @user.email
     #puts title
     #puts @body
     #puts '-----------------------------------------------------------------------------'
     mail to: @user.email,  subject: title
  end
  
  def invite_existing_user_to_account user_id, account_id, invitation
    @user = User.cached_find(user_id)
    mail to: @user.email, subject: "You are invited to an account on DigiRAMP"
  end
  
  def invite_existing_user_to_catalog user_id , title, body, catalog_id 
    #puts '-----------------------------------------------------------------------------'
    #puts 'invite_existing_user_to_catalog'
    #puts '-----------------------------------------------------------------------------'
    @user       = User.cached_find(user_id)
    @title      = title
    @body       = body
    @catalog    = Catalog.cached_find(catalog_id)
    mail to: @user.email, subject: title
    puts ' SUCCESS '
  end
  
  def invite_new_user_to_catalog user_id , title, body , catalog_id
    #puts '-----------------------------------------------------------------------------'
    #puts 'invite_new_user_to_catalog'
    #puts '-----------------------------------------------------------------------------'
    @user       = User.cached_find(user_id)
    @title      = title
    @body       = body
    @catalog    = Catalog.cached_find(catalog_id)
    mail to: @user.email, subject: title
  end

end
