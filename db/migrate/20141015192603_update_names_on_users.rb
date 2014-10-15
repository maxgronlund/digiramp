class UpdateNamesOnUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.validate_info
      if user.user_name.to_s == ''
        user.user_name = user.name
      end
      begin
        user.save!
      rescue
        ap user
      end
    end
  end
end
