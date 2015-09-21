class AddStripeFeeToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :stripe_fee, :integer, default: 33
    
    Admin.update_all(stripe_fee: 33)
    
  end
end
