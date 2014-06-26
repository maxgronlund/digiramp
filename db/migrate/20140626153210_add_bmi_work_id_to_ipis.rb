class AddBmiWorkIdToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :bmi_work_id, :string, default: ''
  end
end
