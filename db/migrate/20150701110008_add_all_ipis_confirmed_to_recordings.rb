class AddAllIpisConfirmedToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :all_ipis_confirmed, :boolean, default: false
  end
end
