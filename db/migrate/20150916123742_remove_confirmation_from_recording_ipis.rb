class RemoveConfirmationFromRecordingIpis < ActiveRecord::Migration
  def change
    remove_column :recording_ipis, :confirmation
  end
end
