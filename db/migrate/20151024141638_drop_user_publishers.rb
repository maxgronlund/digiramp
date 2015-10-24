class DropUserPublishers < ActiveRecord::Migration
  def change
    drop_table :user_publishers
  end
end
