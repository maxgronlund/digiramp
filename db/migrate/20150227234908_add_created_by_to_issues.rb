class AddCreatedByToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :created_by, :string
    
    Issue.find_each do |issue|
      issue.created_by = issue.user.user_name
      issue.save!
    end
  end
end
