class AddUserIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :user_id, :integer
    error_count = 0
    Client.find_each do |client|
      begin
        client.user_id = client.account.user_id
        client.save!
      rescue
        error_count += 1
        client.destroy
      end
    end
    
    add_index :clients, :user_id
    
    #ap '================================================'
    #ap error_count
  end
end
