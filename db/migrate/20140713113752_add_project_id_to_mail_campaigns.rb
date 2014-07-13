class AddProjectIdToMailCampaigns < ActiveRecord::Migration
  def change
    remove_column :project_tasks, :notifcation
    add_column :project_tasks, :notifcation, :datetime
    add_reference :mail_campaigns, :project, index: true
  end
end
