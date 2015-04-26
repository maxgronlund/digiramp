class AddStatementDescriptorToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :statement_descriptor, :string
    add_column :plans, :metadata, :text
  end
end
