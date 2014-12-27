class AddCapacityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_field, :text, default: ''
    
    User.find_each do |user|
      user.save!
    end
  end
end
