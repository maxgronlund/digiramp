class AddZippToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :zipp, :string
  end
end
