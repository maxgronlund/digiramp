class AddDismissedByProjectManagerToCreativeProjectUsers < ActiveRecord::Migration
  def change
    add_column :creative_project_users, :dismissed_by_project_manager, :boolean
  end
end
