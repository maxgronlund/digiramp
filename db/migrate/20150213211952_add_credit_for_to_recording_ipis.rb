class AddCreditForToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :credit_for, :string, default: ''
  end
end
