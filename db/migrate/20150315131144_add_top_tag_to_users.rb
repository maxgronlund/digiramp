class AddTopTagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :top_tag, :string
    
    
    
    
    User.find_each do |user|
      user.save!
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  end
end
