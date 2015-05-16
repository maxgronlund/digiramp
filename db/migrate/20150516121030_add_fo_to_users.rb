class AddFoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fo, :string
  end
end
