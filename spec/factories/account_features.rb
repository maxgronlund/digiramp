FactoryGirl.define do
  factory :account_feature do
    account_type "MyString"
    max_recordings 1
    enable_catalogs false
    max_catalogs 1
    max_catalog_users 1
    multiply_recordings_on_works false
    export_works_as_csv false
    import_works_as_csv false
    import_from_pros false
    manage_opportunities false
    max_account_users 1
    max_ipi_codes "MyString"
  end

end
