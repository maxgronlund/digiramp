module KnowAccountFeaturesHelper

  def find_or_create_account_feature  account_type
    return @account_feature if @account_feature = account_feature_with_name( account_type )
    @plan = FactoryGirl.create(:account_feature, account_type: account_type)
  end
  
  def account_feature_with_name( account_type )
    AccountFeature.find_by(account_type: account_type)
  end

end

World(KnowAccountFeaturesHelper)