class AddRegistrationOriginToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :registration_origin, :string, default: ''
  end
end
