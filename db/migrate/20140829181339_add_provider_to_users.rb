class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, default: 'DigiRAMP'
    add_column :users, :uid, :string, default: ''
  end
end
