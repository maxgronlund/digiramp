class AddPublishingAgreementRefToCommonWorkIpis < ActiveRecord::Migration
  def change
    add_reference :common_work_ipis, :publishing_agreement, index: true, foreign_key: true

  end
end
