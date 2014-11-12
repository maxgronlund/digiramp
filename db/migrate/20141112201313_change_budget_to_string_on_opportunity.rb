class ChangeBudgetToStringOnOpportunity < ActiveRecord::Migration
  def change
    change_column :opportunities, :budget, :string, default: ''
  end
end
