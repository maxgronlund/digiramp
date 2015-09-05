class AddPageUrlToBlogPosts < ActiveRecord::Migration
  def change
    add_column :helps, :request_url, :string
    
  end
end
