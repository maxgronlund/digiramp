class AddDefaultLabelIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_label_id, :integer
    
    User.find_each do |user|
      user.update( default_label_id: user.labels.first.id)
    end
  end
end


