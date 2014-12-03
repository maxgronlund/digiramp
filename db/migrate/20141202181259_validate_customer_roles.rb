class ValidateCustomerRoles < ActiveRecord::Migration
  def change
    User.find_each do |user|
      if user.role.to_s == ''
        user.role == 'Customer'
        user.save!
      end
    end
  end
end
