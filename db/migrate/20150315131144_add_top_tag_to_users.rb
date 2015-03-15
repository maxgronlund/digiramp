class AddTopTagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :top_tag, :string
    
    
    
    
    User.find_each do |user|
      user.set_top_tag
      user.save!
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  end
end
