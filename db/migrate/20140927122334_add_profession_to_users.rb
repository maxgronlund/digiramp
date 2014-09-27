class AddProfessionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profession, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
    remove_column :users, :location
  end
end
