class RemoveForeignKeysOnUserPublishers < ActiveRecord::Migration
  def change
    remove_foreign_key "user_publishers", "users"
    remove_foreign_key "user_publishers", "publishers"
  end
end
