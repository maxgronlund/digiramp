class AddWorkIdToRecordings < ActiveRecord::Migration
  def change
    add_column :common_works, :pro_work_id, :string, default: ''
    add_column :common_works, :pro_catalog, :string, default: ''
  end
end
