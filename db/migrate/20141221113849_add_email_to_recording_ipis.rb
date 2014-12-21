class AddEmailToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :email, :string, default: ''
    add_column :recording_ipis, :confirmed, :boolean, default: false
  end
end
