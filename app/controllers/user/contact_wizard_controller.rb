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
end
