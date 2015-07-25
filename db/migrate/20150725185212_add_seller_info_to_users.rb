class AddSellerInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :seller_info, :json, default: {}
  end
end
