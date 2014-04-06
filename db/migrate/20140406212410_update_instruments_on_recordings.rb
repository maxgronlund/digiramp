class UpdateInstrumentsOnRecordings < ActiveRecord::Migration
  def change
    change_column :recordings, :instruments,  :text
  end
end
