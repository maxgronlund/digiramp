class AddAddDigitalSignatureLaterToUserConfiguration < ActiveRecord::Migration
  def change
    add_column :user_configurations, :add_digital_signature_later, :boolean
  end
end
