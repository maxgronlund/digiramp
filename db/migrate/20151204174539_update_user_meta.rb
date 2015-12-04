class UpdateUserMeta < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.update_meta
      user.save
    end
  end
end
