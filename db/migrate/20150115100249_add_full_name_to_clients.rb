class AddFullNameToClients < ActiveRecord::Migration
  def change
    add_column :clients, :full_name, :string, default: ''
    
    Client.find_each do |client|
      client.save!
    end
  end
end
