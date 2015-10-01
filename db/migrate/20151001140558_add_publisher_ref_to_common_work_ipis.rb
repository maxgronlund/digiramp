class AddPublisherRefToCommonWorkIpis < ActiveRecord::Migration
  def change
    add_reference :common_work_ipis, :publisher, index: true, foreign_key: false
    add_reference :common_work_ipis, :ipi_publisher, index: true, foreign_key: false
    add_column :common_work_ipis, :publishers_email, :string
  end
end
