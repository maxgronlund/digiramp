class AddConfirmationToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :confirmation, :string      , default: 'Missing'
    add_column :recording_ipis, :show_credit_on_recording, :boolean, default: false
    add_column :recording_ipis, :notes, :text, default: ''
  end
end
