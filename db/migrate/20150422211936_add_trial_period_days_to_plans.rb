class AddTrialPeriodDaysToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :trial_period_days, :integer, default: 0
  end
end
