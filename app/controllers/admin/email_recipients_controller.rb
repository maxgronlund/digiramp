class Admin::EmailRecipientsController < ApplicationController
  before_filter :admin_only
  def edit
    #@email_group    = EmailGroup.find(params[:email_group_id])
    #@digiramp_email = DigirampEmail.find(params[:id])
    #
    #unless @digiramp_email.freeze_emails
    # unless @digiramp_email.delivered
    #   @digiramp_email.recipients = @email_group.email_recipients
    # end
    #end
  end


  def index
    @email_group            = EmailGroup.find(params[:email_group_id])
    @mail_list_subscribers  = @email_group.mail_list_subscribers.page(params[:page]).per(50)
  end
  
  def destroy
     @email_group         = EmailGroup.find(params[:email_group_id])
     email_receipient     = MailListSubscriber.find(params[:id])
     @email_receipient_id = email_receipient.id
     email_receipient.destroy
  end
  
  def new
    @email_group         = EmailGroup.find(params[:email_group_id])
  end
  
  
  def create
    @email_group         = EmailGroup.find(params[:email_group_id])
  end
  
  def update
    
    
  end
end
