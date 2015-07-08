class AddPreclearedToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :pre_cleared, :boolean, default: false
    Recording.update_all(pre_cleared: false)
  end
  FlushCacheWorker.perform_async()
end
