class AddArchivedToSelectedOpportunities < ActiveRecord::Migration
  def change
    add_column :selected_opportunities, :archived, :boolean
  end
end
