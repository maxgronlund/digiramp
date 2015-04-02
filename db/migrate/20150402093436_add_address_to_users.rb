class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :text        , default: ''
    add_column :users, :zip_code, :string ,  default: ''
    add_column :users, :phone_number, :string , default: ''
  end
end
