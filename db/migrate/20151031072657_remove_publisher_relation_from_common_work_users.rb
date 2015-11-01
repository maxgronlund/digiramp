class RemovePublisherRelationFromCommonWorkUsers < ActiveRecord::Migration
  def change
    remove_column :common_work_users, :publisher_belongs_to, :string
  end
end
