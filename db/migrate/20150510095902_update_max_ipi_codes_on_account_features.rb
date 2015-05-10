class UpdateMaxIpiCodesOnAccountFeatures < ActiveRecord::Migration
  def change
    rename_column :account_features, :max_ipi_codes, :max_ipi_codesx         
    add_column :account_features, :max_ipi_codes, :integer,           default: 0
    
    AccountFeature.find_each do |account_feature|
      account_feature.max_ipi_codes = account_feature.max_ipi_codesx.to_i
      account_feature.save!
      
    end
    
    remove_column :account_features, :max_ipi_codesx
  end
end
