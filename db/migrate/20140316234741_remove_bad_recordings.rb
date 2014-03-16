class RemoveBadRecordings < ActiveRecord::Migration
  def change
    recordings = Recording.where(common_work_id: nil)
    recordings.delete_all
  end
end
