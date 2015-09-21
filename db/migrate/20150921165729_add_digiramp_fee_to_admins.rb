class AddDigirampFeeToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :digiramp_fee, :decimal, default: 2.0
  end
end
