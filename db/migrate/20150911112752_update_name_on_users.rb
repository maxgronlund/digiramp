class UpdateNameOnUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.name = user.user_name
      user.save(validate: false)
    end
  end
end
