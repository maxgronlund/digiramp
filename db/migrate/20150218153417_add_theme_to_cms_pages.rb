class AddThemeToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :theme, :string, default: 'default'
  end
end
