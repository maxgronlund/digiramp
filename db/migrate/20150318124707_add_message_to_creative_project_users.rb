class AddMessageToCreativeProjectUsers < ActiveRecord::Migration
  def change
    add_column :creative_project_users, :message, :text
    add_column :creative_project_users, :creative_project_role_id, :integer
    add_index :creative_project_users, :creative_project_role_id
    
    remove_column :creative_project_roles, :creative_project_user_id
  end
end
