class SecurePersonalPublishing < ActiveRecord::Migration
  def up
    
    User.find_each do |user|
      UserAssetsFactory.new user
    end
  end
  
  def down
    
  end
end
