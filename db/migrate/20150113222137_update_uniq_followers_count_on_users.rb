class UpdateUniqFollowersCountOnUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.uniq_followers_count = Uniqifyer.uniqify(user.followers_count)
      user.save!
    end
  end
end
