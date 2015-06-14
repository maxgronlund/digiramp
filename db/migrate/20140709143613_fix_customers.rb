class FixCustomers < ActiveRecord::Migration
  def change
    
    User.all.each do |user|
      if user.role.to_s == '' || user.role.to_s == 'cuctomer'
        user.role = 'Customer'
        user.save!
      end
    end

    
  end
  

end
