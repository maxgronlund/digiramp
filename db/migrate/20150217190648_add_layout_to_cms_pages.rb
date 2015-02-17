class AddLayoutToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :layout, :string, default: 'Alabama'
  end
end
