class AddCurentCatalogToUsers < ActiveRecord::Migration
  def change
    add_column :users, :curent_catalog_id, :integer
    
    User.all.each do |user|
      if user.account.nil?
        user.destroy
      else
        user.curent_catalog_id = user.account.default_catalog_id
        user.save
      end
    end
  end
end
