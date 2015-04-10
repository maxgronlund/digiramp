require 'uri'

class MessageMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.send.subject
  #
  def send_message message_id
    
    @message      = Message.cached_find(message_id)
    @receiver     = @message.receiver
    @sender       = @message.sender
    @message_url  = url_for( controller: 'messages', action: 'show', user_id: @receiver.id, id: message_id)
    @unsubscribe_url = '#'
    @avatar_url   = ( URI.parse(root_url) + @sender.image_url(:avatar_92x92) ).to_s

    mail to: @receiver.email, subject: "#{@sender.user_name} has sent you a message on DigiRAMP"

  end
end
