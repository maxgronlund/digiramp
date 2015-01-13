class AddUniqCompletenessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uniq_completeness, :string
    
    User.find_each do |user|
      user.uniq_completeness = Uniqifyer.uniqify(user.completeness)
      user.uniq_followers_count = Uniqifyer.uniqify(user.followers_count)
      user.save!
    end
    
  end
end
