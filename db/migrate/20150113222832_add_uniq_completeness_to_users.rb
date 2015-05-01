class AddUniqCompletenessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uniq_completeness, :string
    
    User.find_each do |user|

      user.uniq_followers_count = user.followers_count.to_uniq
      user.save!
    end
    
  end
end
