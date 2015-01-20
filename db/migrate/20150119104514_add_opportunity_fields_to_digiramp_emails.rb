class AddOpportunityFieldsToDigirampEmails < ActiveRecord::Migration
  def change
    add_column :digiramp_emails, :kind, :string       , default: ''
    add_column :digiramp_emails, :budget, :string     , default: ''
    add_column :digiramp_emails, :territory, :string  , default: ''
    add_column :digiramp_emails, :uuid, :string       , default: ''
    add_column :digiramp_emails, :opportunity_id,  :integer
    add_column :digiramp_emails, :deadline,             :date
    
    
    add_index  :digiramp_emails, :opportunity_id

  end
end
