class AddEmailToPublishingDeal < ActiveRecord::Migration
  def change
    add_column :publishing_agreements, :email, :string
  end
end
