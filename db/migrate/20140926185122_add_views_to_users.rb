class AddViewsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :views, :integer, default: 0
  end
end
