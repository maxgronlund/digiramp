class AddSuperCatalogIdToSuperUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_catalog_user_id, :integer
    add_index :users,  :super_catalog_user_id
    
    User.supers.each do |user|
      catalog_user = CatalogUser.create(user_id: user.id)
      catalog_user.grand_all_permissions
      user.super_catalog_user_id = catalog_user.id
      user.save
    end
  end
end
