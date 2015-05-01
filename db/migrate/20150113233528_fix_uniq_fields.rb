class FixUniqFields < ActiveRecord::Migration
  def change
    change_column :users, :uniq_completeness, :string, default: ''
    change_column :users, :uniq_followers_count, :string, default: ''
    
    User.find_each do |user|
      user.uniq_completeness = user.completeness.to_uniq
      user.uniq_followers_count = user.followers_count.to_uniq
      user.save!
    end
  end
end
