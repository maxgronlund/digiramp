class AddAddLegalInformationsLaterToUserConfigurations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :add_legal_informations_later, :boolean
  end
end
