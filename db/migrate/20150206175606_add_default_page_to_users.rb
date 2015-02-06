class AddDefaultPageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_cms_page_id, :integer
    add_index :users, :default_cms_page_id
  end
end
