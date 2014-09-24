class AddUserNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    
    
    
    User.all.each do |user|
      user.user_name = user.email.gsub('@', '-').gsub('.', '-').downcase.strip
      user.slug      = nil
      user.save!
      puts user.friendly_id
    end
    
    
  end
end
