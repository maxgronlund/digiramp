class AddDownloadbleToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :downlodable, :boolean, default: false
  end
end
