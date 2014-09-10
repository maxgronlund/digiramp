class AddTerritoryOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :territory, :string, default: ''
  end
end
