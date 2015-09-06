class AddAddPhysicalProductLaterToUserConfigurations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :add_physical_product_later, :boolean
    #add_column :user_configurations, :add_a_recording_to_the_shop_later, :boolean
    
  end
end
