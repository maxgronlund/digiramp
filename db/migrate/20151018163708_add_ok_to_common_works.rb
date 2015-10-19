class AddOkToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :ok, :boolean
  end
end
