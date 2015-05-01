class UpdateUniqFollowersCountOnUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.uniq_followers_count = user.followers_count.to_uniq
      user.save!
    end
  end
end
