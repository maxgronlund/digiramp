class AddCompletenessUsers < ActiveRecord::Migration
  def change
    add_column :users, :completeness ,:integer, default: 0;
    
    User.find_each do |user|
      user.save!
    end
  end
end
