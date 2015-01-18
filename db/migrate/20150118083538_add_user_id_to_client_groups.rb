class AddUserIdToClientGroups < ActiveRecord::Migration
  def change
    add_column :client_groups, :user_id, :integer
    
    add_index :client_groups, :user_id
    
    ClientGroup.find_each do |client_group|
      client_group.user_id = client_group.account.user_id
      client_group.save
    end
  end
end
