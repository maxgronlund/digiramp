class AddInitializedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :initialized, :boolean, default: false

    User.find_each do |user|
      if user.updated_at != user.created_at.change(min: 1) 
        user.initialized  = true
        user.save! 
      end
      
    end
  end
end
