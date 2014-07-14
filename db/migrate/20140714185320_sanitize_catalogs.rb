class SanitizeCatalogs < ActiveRecord::Migration
  def change
    CatalogUser.destroy_all
  end

end
