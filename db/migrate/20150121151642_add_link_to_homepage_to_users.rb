class AddLinkToHomepageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_to_homepage, :string
  end
end
