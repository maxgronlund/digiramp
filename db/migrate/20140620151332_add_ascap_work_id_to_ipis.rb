class AddAscapWorkIdToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :ascap_work_id, :string
  end
end
