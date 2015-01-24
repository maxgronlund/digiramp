class ClientInvitationMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_invitation_mailer.send_with_avatar.subject
  #
  def send_one_with_avatar client_invitation_id
    @client_invitation    = ClientInvitation.cached_find(client_invitation_id)
    
    @client               = @client_invitation.client
    @inviter              = @client_invitation.user
    @accept_url           = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id: @client_invitation.uuid )
    @decline_url          = url_for( controller: '/contact_invitations', action: 'decline_invitation', contact_invitation_id: @client_invitation.uuid )
    
    
    
    
    
    
    #@decline_all_url      = url_for( controller: '/contact_invitations', action: 'decline_all_from_digiramp', contact_invitation_id: @client_invitation.uuid )
    #@info_url             = url_for( controller: '/contact_invitations', action: 'info', contact_invitation_id: @client_invitation.uuid )
    
    
    
    
    
    
    
    
    #@message      = Message.cached_find(message_id)
    #@receiver     = @message.receiver
    #@sender       = @message.sender
    #@message_url  = url_for( controller: 'messages', action: 'show', user_id: @receiver.id, id: message_id)
    #@unsubscribe_url = '#'
    #@avatar_url   = ( URI.parse(root_url) + @sender.image_url(:avatar_92x92) ).to_s
    
    
    
    
    
    mail to: 'max@pixelsonrails.com', subject: "I'd like to add you to my network of music professionals"
    
    

    
  end

end
