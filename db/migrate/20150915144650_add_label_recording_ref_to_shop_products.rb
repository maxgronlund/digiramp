class AddLabelRecordingRefToShopProducts < ActiveRecord::Migration
  def change
    add_reference :shop_products, :label_recording, index: true, foreign_key: false
    add_reference :shop_products, :distribution_agreement, index: true, foreign_key: false
    add_reference :distribution_agreements, :user, index: true, foreign_key: false
    add_column :distribution_agreements, :title, :string
    
    add_foreign_key "shop_products", "label_recordings", on_delete: :cascade
    
    DistributionAgreement.find_each do |distribution_agreement|
      distribution_agreement.update(user_id: distribution_agreement.account.user_id,
                                    title: distribution_agreement.account.user.get_full_name + ' Distribution')
    end

  end
end
