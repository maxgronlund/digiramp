class AddPublishingDesigneeToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :publishing_designee, :boolean           , default: false
    add_column :recording_ipis, :publishing_designee, :boolean , default: false
  end
end
