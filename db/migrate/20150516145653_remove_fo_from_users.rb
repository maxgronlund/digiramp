class RemoveFoFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :fo, :string
  end
end
