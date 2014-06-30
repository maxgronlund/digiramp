class AddInBucketToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :in_bucket, :boolean, default: false
  end
end
