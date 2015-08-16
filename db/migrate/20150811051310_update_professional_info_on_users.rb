class UpdateProfessionalInfoOnUsers < ActiveRecord::Migration
  def change
    
    Address.where(addressable_type: 'User').destroy_all
    
    
    User.find_each do |user|
      address                 = user.address
      address.first_name      = user.first_name
      address.last_name       = user.last_name
      address.address_line_1  = user.address_line_1
      address.address_line_2  = user.address_line_2
      address.city            = user.city
      address.zip_code        = user.zip_code
      address.country         = user.country                    
      address.save(validate: false)
    
    end
    
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address_line_1
    remove_column :users, :address_line_2
    remove_column :users, :city
    remove_column :users, :zip_code
    remove_column :users, :country
  end
end
