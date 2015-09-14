class ChangeBudgetOnCreativeProjectRoles < ActiveRecord::Migration
  def change
    add_column :creative_project_roles, :temp, :decimal
    
    CreativeProjectRole.find_each do |creative_project_role|
      creative_project_role.temp = creative_project_role.budget.to_f
    end
    remove_column :creative_project_roles, :budget
    rename_column :creative_project_roles, :temp, :budget
  end
end
