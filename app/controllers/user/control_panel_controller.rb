class User::ControlPanelController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  #before_filter :access_account
  
  
  def index
    
    @email_groups = EmailGroup.where(subscripeable: true)
    #@mail_subscribtions = MailListSubscriber.where(user_id: @user.id)
    #
    #if email_group_ids = EmailGroup.where(subscripeable: true).pluck(:id)
    #  email_group_ids  -= MailListSubscriber.where(user_id: @user.id ).pluck(:email_group_id)
    #  @email_groups     = EmailGroup.where(id: email_group_ids)
    #end
    
  end
end
