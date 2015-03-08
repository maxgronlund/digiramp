class AddTitleToCmsBanners < ActiveRecord::Migration
  def change
    add_column :cms_banners, :title, :string, default: ''
    add_column :cms_banners, :body, :text,    default: ''
  end
end
