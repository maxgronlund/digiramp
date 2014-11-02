class AddFbBadgeToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :fb_badge, :string
  end
end
