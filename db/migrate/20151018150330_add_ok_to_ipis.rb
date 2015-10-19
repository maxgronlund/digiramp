class AddOkToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :ok, :boolean
  end
end
