class AddCreativeProjectUserIdToCreativeProjectRecources < ActiveRecord::Migration
  def change
    add_column :creative_project_resources, :creative_project_user_id, :integer
    add_index :creative_project_resources, :creative_project_user_id
  end
end
