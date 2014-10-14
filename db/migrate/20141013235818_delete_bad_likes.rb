class DeleteBadLikes < ActiveRecord::Migration
  def change
     Like.where(user_id: nil).destroy_all
  end
end
