class UpdateSearchFieldOnUsers2 < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.save!
    end
  end
end
