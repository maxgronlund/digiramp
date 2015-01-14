class FixUniqFields < ActiveRecord::Migration
  def change
    change_column :users, :uniq_completeness, :string, default: ''
    change_column :users, :uniq_followers_count, :string, default: ''
    
    User.find_each do |user|
      user.uniq_completeness = Uniqifyer.uniqify(user.completeness)
      user.uniq_followers_count = Uniqifyer.uniqify(user.followers_count)
      user.save!
    end
  end
end
