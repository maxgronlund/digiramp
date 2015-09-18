class UpdatePublishersV2 < ActiveRecord::Migration
  def up
    
    #create_table :publishing_agreement_publishers do |t|
    #  t.belongs_to :publisher, index: true, foreign_key: false
    #  t.belongs_to :publishing_agreement, index: true, foreign_key: false
    #  t.timestamps null: false
    #end
    #
    #add_foreign_key "publishing_agreement_publishers", "publishers", on_delete: :cascade
    #add_foreign_key "publishing_agreement_publishers", "publishing_agreemens", on_delete: :cascade
    #
    #Publisher.destroy_all
    #rename_column :publishers, :i_am_my_own_publisher, :personal_publisher
    #
    #PublishingAgreement.destroy_all
    #add_column :publishing_agreement, :personal_publisher, :boolean, default: false
    #add_column :publishing_agreement, :personal_publisher, :boolean, default: false
    #
    #User.find_each do |user|
    #  user.setup_personal_publishing
    #end
    #
  end
  
  def down
    #drop_table :publishing_agreement_publishers
    #rename_column :publishers, :personal_publisher, :i_am_my_own_publisher
  end
end
