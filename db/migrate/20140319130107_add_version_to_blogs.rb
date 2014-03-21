class AddVersionToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :version, :integer, default: 0
  end
end
