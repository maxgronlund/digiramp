class AddUserIdToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :user_id, :integer, default: 0
  end
end
