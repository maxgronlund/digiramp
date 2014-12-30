class AddFeaturedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :featured, :boolean,     default: false
    add_column :users, :featured_date, :datetime
    
    User.find_each do |user|
      user.featured_date = DateTime.now 
      user.save!
    end
  end
end
