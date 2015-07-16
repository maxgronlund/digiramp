class AddMaxSubmissionsPrUserToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :max_submisions_pr_user, :integer, default: 10
  end
end
