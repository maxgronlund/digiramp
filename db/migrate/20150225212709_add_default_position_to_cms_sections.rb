class AddDefaultPositionToCmsSections < ActiveRecord::Migration
  def change
    change_column :cms_sections, :position, :integer, default: 0
  end
end
