class AddVocalToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :vocal, :string, default: ''
  end
end
