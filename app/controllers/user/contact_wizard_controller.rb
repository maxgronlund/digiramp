class User::ContactWizardController < ApplicationController
  before_filter :access_user
  
  def fill_form
    @contact = Client.new
  end

  def submit_form
  end

  def upload_file
  end

  def upload_custom_csv
  end

  def submit_custom_csv
  end

  def upload_linkedin_csv
  end

  def submit_linkedin_csv
  end
  
  def add_contacts_by_emails
  end
  
  def submit_contacts_by_emails
    count = 0
    params[:emails].split(',').each do |raw_email|
      raw_email.split(' ').each do |email|
        if email = EmailSanitizer.saintize( email )
          Client.where(email: email, user_id: @user.id).first_or_create(email: email, user_id: @user.id, account_id: @user.account_id)
          count += 1
        end
      end
    end
    @message = "#{count} emails added"
  end
  
end
