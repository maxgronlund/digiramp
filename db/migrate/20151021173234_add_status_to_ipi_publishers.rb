class AddStatusToIpiPublishers < ActiveRecord::Migration
  def change
    add_column :ipi_publishers, :status, :integer, default: 0
    IpiPublisher.update_all(status: 1)
  end
end
