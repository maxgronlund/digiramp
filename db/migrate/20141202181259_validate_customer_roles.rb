class ValidateCustomerRoles < ActiveRecord::Migration
  def change
    User.find_each do |user|
      if user.role.to_s == ''
        user.role == 'Customer'
        if user.name.to_s == ''
          user.name = User.create_uniq_user_name_from_email user.email
        end
        user.save!
      end
    end
  end
end
