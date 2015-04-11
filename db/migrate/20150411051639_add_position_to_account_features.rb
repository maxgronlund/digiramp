class AddPositionToAccountFeatures < ActiveRecord::Migration
  def change
    add_column :account_features, :position, :integer, default: 100
    add_column :account_features, :enabled, :boolean, default: false
  end
end
