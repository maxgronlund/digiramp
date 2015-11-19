class AddUserConfigutationUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_configuration_configured, :boolean
    
    UserConfiguration.find_each do |user_configuration| user_configuration.save end
  end
end
