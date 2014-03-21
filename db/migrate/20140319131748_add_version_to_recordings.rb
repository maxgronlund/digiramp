class AddVersionToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :cache_version, :integer, default: 0
  end
end
