FactoryGirl.define do
  factory :account_feature do |f|
    f.account_type "DigiRAMP-Pro"
    f.max_recordings 100
    f.enable_catalogs true
    f.max_catalogs 5
    f.max_catalog_users 5
    f.multiply_recordings_on_works true
    f.export_works_as_csv false
    f.import_works_as_csv false
    f.import_from_pros false
    f.manage_opportunities true
    f.max_account_users 5
    f.max_ipi_codes 10
    f.position 100
    f.description "Pro DigiRAMP Plan"
  end

end
