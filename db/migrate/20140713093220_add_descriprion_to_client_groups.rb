class AddDescriprionToClientGroups < ActiveRecord::Migration
  def change
    add_column :client_groups, :description, :text
    add_column :client_groups, :user_uuid, :string
    
    
  end
end
