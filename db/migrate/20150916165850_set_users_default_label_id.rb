class SetUsersDefaultLabelId < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      if label = Label.find_by(user_id: user.id)
        user.update(default_label_id: label.id)
      end
    end
  end
end
