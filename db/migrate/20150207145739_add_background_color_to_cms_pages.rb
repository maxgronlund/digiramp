class AddBackgroundColorToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :background_color, :string, default: '#FFF'
    add_column :cms_pages, :text_color, :string, default: '#555'
  end
end
