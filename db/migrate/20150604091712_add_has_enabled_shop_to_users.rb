class AddHasEnabledShopToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_enabled_shop, :boolean, default: false
    add_column :users, :has_an_approved_shop, :boolean, default: false
    
    User.update_all(has_enabled_shop: false, has_an_approved_shop: false)
  end
end
