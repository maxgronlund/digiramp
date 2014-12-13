class Admin::EmailGroupRecipientsController < ApplicationController
  before_filter :admin_only
  def edit
    @email_group    = EmailGroup.find(params[:id])

    recipients = ''
    @count = 0
    User.find_each do |user|
      if email = EmailValidator.saintize( user.email )
        recipients << email << ','
        @count += 1
      end
    end
    
    @email_group.email_recipients = recipients

    
  end

  def update
  end
end
