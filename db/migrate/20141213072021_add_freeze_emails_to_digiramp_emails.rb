class AddFreezeEmailsToDigirampEmails < ActiveRecord::Migration
  def change
    add_column :digiramp_emails, :freeze_emails, :boolean, default: false
  end
end
