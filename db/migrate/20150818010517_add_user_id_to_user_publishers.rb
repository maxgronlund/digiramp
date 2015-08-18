class AddUserIdToUserPublishers < ActiveRecord::Migration
  def change
    add_reference :user_publishers, :user, index: true
    
    add_foreign_key :user_publishers, :users, on_delete: :cascade
  end
end
