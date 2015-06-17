class UpdateAddresses < ActiveRecord::Migration
  def change
    rename_column    :users, :address, :address_line_1
    add_column       :users, :address_line_2, :text
    add_column       :addresses, :zip_code, :string
    
  end
end
