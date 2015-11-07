class AddOkToCommonWorkPublishers < ActiveRecord::Migration
  def change
    add_column :common_work_ipi_publishers, :ok, :boolean
  end
end
