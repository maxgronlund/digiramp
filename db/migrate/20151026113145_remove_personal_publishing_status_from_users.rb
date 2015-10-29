class RemovePersonalPublishingStatusFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :personal_publishing_status, :string
    remove_column :users, :publishing_administrators_email, :string
  end
end
