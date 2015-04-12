class AddAddressToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :address1, :text
    add_column :registrations, :city, :string
    add_column :registrations, :state, :string
    add_column :registrations, :country, :string
    add_column :registrations, :zip, :string
  end
end
