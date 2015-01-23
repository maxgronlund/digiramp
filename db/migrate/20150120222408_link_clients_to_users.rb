class LinkClientsToUsers < ActiveRecord::Migration
  def change
    add_column :clients, :is_member, :boolean, default: false
    add_column :clients, :member_id, :integer
    add_index  :clients, :member_id
    
    Client.find_each do |client|
      if client.email.to_s != ''
        if user = User.where(email: client.email).first
          client.member_id = user.id
          client.is_member = true
          client.save!
        end
      end
    end
  end
end
