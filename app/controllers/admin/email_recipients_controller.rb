class Admin::EmailRecipientsController < ApplicationController
  before_filter :admin_only
  def edit
    @email_group    = EmailGroup.find(params[:email_group_id])
    @digiramp_email = DigirampEmail.find(params[:id])
    
    unless @digiramp_email.freeze_emails
     unless @digiramp_email.delivered
       @digiramp_email.recipients = @email_group.email_recipients
     end
    end
  end

  def update
  end
end
