class UpdateRoleOnUsers < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      unless user.role == 'Super'
        user.role = 'Customer'
        user.save!
      end
    end
  end
end
