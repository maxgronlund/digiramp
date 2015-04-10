class CreateAccountFeatures < ActiveRecord::Migration
  def change
    create_table :account_features do |t|
      t.string :account_type
      t.integer :max_recordings
      t.boolean :enable_catalogs
      t.integer :max_catalogs
      t.integer :max_catalog_users
      t.boolean :multiply_recordings_on_works
      t.boolean :export_works_as_csv
      t.boolean :import_works_as_csv
      t.boolean :import_from_pros
      t.boolean :manage_opportunities
      t.integer :max_account_users
      t.string :max_ipi_codes

      t.timestamps
    end
    
    add_column :accounts, :account_feature_id, :integer
    add_index :accounts, :account_feature_id
    
    pro_accounts_features = AccountFeature.create(account_type: 'Pro', 
                              max_recordings:                 10000,
                              enable_catalogs:                true,
                              max_catalogs:                   10,
                              max_catalog_users:              10,
                              multiply_recordings_on_works:   true,
                              export_works_as_csv:           false,
                              import_works_as_csv:           true,
                              import_from_pros:               false,
                              manage_opportunities:           true,
                              max_account_users:              10,
                              max_ipi_codes:                  10
                            )
    
    pro_accounts = Account.where(account_type: 'Pro')
    pro_accounts.update_all(account_feature_id: pro_accounts_features.id)
    
    

    
    social_accounts_features = AccountFeature.create(account_type: 'Social', 
                              max_recordings:                 10000,
                              enable_catalogs:                false,
                              max_catalogs:                   1,
                              max_catalog_users:              1,
                              multiply_recordings_on_works:   false,
                              export_works_as_csv:           false,
                              import_works_as_csv:           false,
                              import_from_pros:               false,
                              manage_opportunities:           false,
                              max_account_users:              1,
                              max_ipi_codes:                  1
                            )
    
    social_accounts = Account.where(account_type: 'Social')
    social_accounts.update_all(account_feature_id: social_accounts_features.id)
    
    

    
    business_accounts_features = AccountFeature.create(account_type: 'Business', 
                              max_recordings:                 10000,
                              enable_catalogs:                true,
                              max_catalogs:                   10,
                              max_catalog_users:              10,
                              multiply_recordings_on_works:   true,
                              export_works_as_csv:           false,
                              import_works_as_csv:           true,
                              import_from_pros:               false,
                              manage_opportunities:           true,
                              max_account_users:              10,
                              max_ipi_codes:                  10
                            )
    
    

    
    enterprice_accounts_features = AccountFeature.create(account_type: 'Enterprice', 
                              max_recordings:                 10000,
                              enable_catalogs:                true,
                              max_catalogs:                   10,
                              max_catalog_users:              10,
                              multiply_recordings_on_works:   true,
                              export_works_as_csv:           false,
                              import_works_as_csv:           true,
                              import_from_pros:               false,
                              manage_opportunities:           true,
                              max_account_users:              10,
                              max_ipi_codes:                  10
                            )
    
    #business_accounts = Account.where(account_type: 'Business')
    #business_accounts.update_all(account_feature_id: social_accounts_features.id)
    
    
  end
end
