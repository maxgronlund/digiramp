class RemoveDubletCatalogUsers < ActiveRecord::Migration
  def change
    
    Catalog.all.each do |catalog|
      
      user_ids = []
      # collect user ids
      catalog.catalog_users.each do |catalog_user|
        user_ids << catalog_user.user_id
      end
      
      ap user_ids
      puts '----------------------------------'
      # filter down ids
      user_ids.uniq!
      
      # iterate catalog users
      catalog.catalog_users.each do |catalog_user|
        # remove from list
        if user_ids.include? catalog_user.user_id 
          user_ids -= [catalog_user.user_id ]
        else
          # delete
          catalog_user.destroy!
        end
      end
    end
  end
end
