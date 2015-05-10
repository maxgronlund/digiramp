class AddPlanRefToAccountFeatures < ActiveRecord::Migration
  def change
    add_reference :account_features, :plan, index: true, foreign_key: true
  end
end
