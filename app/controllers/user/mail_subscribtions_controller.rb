class User::MailSubscribtionsController < ApplicationController
  
  before_filter :access_user
  
  
  def index
    @mail_subscribtions = MailListSubscriber.where(user_id: @user.id)
    
    if email_group_ids = EmailGroup.where(subscripeable: true).pluck(:id)
      email_group_ids  -= MailListSubscriber.where(user_id: @user.id ).pluck(:email_group_id)
      @email_groups     = EmailGroup.where(id: email_group_ids)
    end
    
    
  end
  
  def create
    @mail_subscribtion = MailListSubscriber.create(mail_subscriber_params)
    @email_group_id    = @mail_subscribtion.email_group_id
  end
  
  def destroy

    mail_subscribtion = MailListSubscriber.find(params[:id])
    @mail_subscribtion_id = mail_subscribtion.id
    @email_group  = mail_subscribtion.email_group
    mail_subscribtion.destroy
    
  end
  
  private
  
  def mail_subscriber_params
    params.require(:mail_list_subscriber).permit!
  end
  
  
end
