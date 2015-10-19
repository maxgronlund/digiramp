class AddOkToCommonWorkIpis < ActiveRecord::Migration
  def change
    add_column :common_work_ipis, :ok, :boolean
  end
end
