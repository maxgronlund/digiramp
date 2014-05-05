class CatalogablePermissions < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog_item
end
