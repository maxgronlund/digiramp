class AddTeaserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :teaser, :text
  end
end
