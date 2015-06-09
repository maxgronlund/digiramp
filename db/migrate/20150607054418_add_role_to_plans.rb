class AddRoleToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :account_type, :string
  end
end
