class GetRidOfDefaultCatalogs < ActiveRecord::Migration
  def change
    
    Catalog.all.each do |catalog|
      catalog.destroy! if catalog.title == 'Default catalog'
    end
    
    
  end
end
