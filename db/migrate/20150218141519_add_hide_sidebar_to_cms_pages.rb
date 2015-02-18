class AddHideSidebarToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :hide_sidebar, :boolean, default: false
  end
end
