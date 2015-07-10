class ReprocessSearchOnUsers < ActiveRecord::Migration
  def change
    User.find_each do |user|
      #UserSearchField.process user
      user.save
    end
  end
end
