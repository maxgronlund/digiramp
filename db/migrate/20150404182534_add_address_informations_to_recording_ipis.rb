class AddAddressInformationsToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :address, :text        , default: ''
    add_column :recording_ipis, :phone_number, :string , default: ''
  
    RecordingIpi.update_all(address: '', phone_number: '')
  end
end
