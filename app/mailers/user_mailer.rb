class UserMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  #def reply_mail contact
  #  @contact = contact
  #  @message = MailMessage.contact_confirmation_mail
  #  mail to: contact.mail, subject: @message.subject
  #end
  #
  #def contact_mail contact
  #  @contact = contact
  #  mail to: "info@digiramp.org", subject: "Contact request from DigiRAMP"
  #end
  #
  #def representative_invitation( representative, account, password)
  #  @representative = representative
  #  @password       = password
  #  @message        = MailMessage.contact_confirmation_mail
  #  mail to: @representative.user.email, subject: "#{@message.subject}  for #{account.title} "
  #end
  
  def password_reset user
    @user           = user
    @message        = MailMessage.password_reset
    #mail to: @user.email, subject: "#{@message.subject}"
    mail to: @user.email, subject: "reset password"
  end
  
  def invite_new_user_to_account user_id, account_id, invitation_message
     @user            = User.cached_find(user_id)
     @message         = invitation_message
     puts '-----------------------------------------------------------------------------'
     puts invitation_message
     puts '-----------------------------------------------------------------------------'
     mail to: @user.email, subject: "An invitation from DigiRAMP"
  end
  
  def invite_existing_user_to_account user_id, account_id, invitation
    @user = User.cached_find(user_id)
    mail to: @user.email, subject: "you are invited old friend"
  end
  
  #def signup_confirmation user_id, account_id, invitation_massage
  #  @user                 = User.find(user_id)
  #  @account              = Account.find(account_id)
  #  @message              = MailMessage.signup_confirmation
  #  @invitation_massage   = invitation_massage
  #  mail to: @user.email, subject: "#{@message.subject}"
  #end
  #
  #def new_account_and_user_confirmation options
  #  @user                 = options[:user]
  #  @account              = options[:account]
  #  @message              = MailMessage.new_account_and_user_confirmation
  #  mail to: @user.email, subject: "#{@message.subject}"
  #end
  #
  #def invite_existing_user_to_account options
  #  @user                 = options[:user]
  #  @account              = options[:account]
  #  @message              = MailMessage.invite_existing_user_to_account
  #  mail to: @user.email, subject: "#{@message.subject}"
  #end
  #
  #def invite_to_music_opportunity options
  #
  #  @to_user              = options[:to_user]
  #  @from_user            = options[:from_user]
  #  @music_opportunity    = options[:music_opportunity]
  #  @account              = options[:account]
  #  
  #  mail to: @to_user.email, subject: "you are invited"
  #end
  #
  #def invite_to_music_opportunity_and_signup options
  #  @user                 = options[:to_user]
  #  @from_user            = options[:from_user]
  #  @music_opportunity    = options[:music_opportunity]
  #  @account              = options[:account]
  # 
  #  
  #  mail to: @user.email, subject: "you are invited to an music opportunity"
  #end
  

  
  #def invite_to_account user_id, account_id, invitation_message
  #
  #  @user               = User.find(user_id)
  #  @account            = Account.find(account_id)
  #  @invitation_message = invitation_message
  #  @message            = MailMessage.account_invitation.body
  #  mail to: @user.email, subject: "Invitation to #{@account.title} at DigiRAMP"
  #
  #end
  
  
  
end
