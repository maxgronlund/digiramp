class RemamePublishersOnCreativeProjects < ActiveRecord::Migration
  def change
    rename_column :creative_projects, :publichers, :publishers
  end
end
