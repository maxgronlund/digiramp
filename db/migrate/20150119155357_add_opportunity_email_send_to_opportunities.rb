class AddOpportunityEmailSendToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :opportunity_email_send, :boolean, default: false
  end
end
