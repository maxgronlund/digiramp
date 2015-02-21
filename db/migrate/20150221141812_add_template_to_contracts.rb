class AddTemplateToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :template, :boolean, default: false
  end
end
