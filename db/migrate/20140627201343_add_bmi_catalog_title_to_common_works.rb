class AddBmiCatalogTitleToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :bmi_catalog, :string, default: 'Main catalog'
  end
end
