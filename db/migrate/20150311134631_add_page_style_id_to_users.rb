class AddPageStyleIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :page_style, index: true
  end
end
