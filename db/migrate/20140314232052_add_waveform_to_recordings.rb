class AddWaveformToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :waveform, :string, default: ''
  end
end
