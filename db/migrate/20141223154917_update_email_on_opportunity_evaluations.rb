class UpdateEmailOnOpportunityEvaluations < ActiveRecord::Migration
  def change
    #remove_column :opportunity_evaluations, :email
    add_column    :opportunity_evaluations, :emails, :text
    add_column    :opportunity_evaluations, :subject, :string
    add_column    :opportunity_evaluations, :body, :text
  end
end
