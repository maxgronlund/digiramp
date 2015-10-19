class AddOkToPublishingAgreements < ActiveRecord::Migration
  def change
    add_column :publishing_agreements, :ok, :boolean
  end
end
