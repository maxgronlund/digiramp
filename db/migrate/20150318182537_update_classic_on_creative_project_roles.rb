class UpdateClassicOnCreativeProjectRoles < ActiveRecord::Migration
  def change
    
    rename_column :creative_project_roles, :classic, :classical
  end
end
