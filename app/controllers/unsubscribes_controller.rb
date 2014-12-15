class UnsubscribesController < ApplicationController
  def index
  end
  
  def update
    
  end
  
  def show
    message = ''
    success = false
    if user = User.where(email: params[:email]).first
    
      if user.authenticate(params[:password])
        
        if email_group = EmailGroup.where(uuid: params[:id]).first
          if mail_list_subscriber = MailListSubscriber.where(email_group_id: email_group.id, user_id: user.id).first
            mail_list_subscriber.destroy
            message = 'You have been removed from the mail list'
          else
            message = 'You are no longer on the mail list'
          end
          success = true
        end
      else
        message = "Invalid password"
      end
    else
      message = "No user with email: #{params[:email]} found"
    end

    redirect_to unsubscribes_path(uuid: params[:id], message: message, success: success)
    
  end
  
  def destroy
    if email_group = EmailGroup.where(uuid: params[:id]).first
      if mail_list_subscriber = MailListSubscriber.where(email_group_id: email_group.id, user_id: current_user.id).first
        mail_list_subscriber.destroy
      end
    end
    redirect_to unsubscribes_path(uuid: params[:id], message: 'You have been removed from the mail list', success: true)
  end
  
  
end
