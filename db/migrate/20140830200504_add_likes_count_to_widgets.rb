class AddLikesCountToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :likes_count, :integer, default: 0

  end
end
