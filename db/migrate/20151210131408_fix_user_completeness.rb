class FixUserCompleteness < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      UserCompleteness.process user
      user.save(validate: false)
    end
  end
end
