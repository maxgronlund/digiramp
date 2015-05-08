class RemoveUserFromCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :user_id, :string
  end
end
