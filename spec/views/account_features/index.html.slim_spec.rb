require 'rails_helper'

RSpec.describe "account_features/index", :type => :view do
  before(:each) do
    assign(:account_features, [
      AccountFeature.create!(
        :account_type => "Account Type",
        :max_recordings => 1,
        :enable_catalogs => false,
        :max_catalogs => 2,
        :max_catalog_users => 3,
        :multiply_recordings_on_works => false,
        :export_works_as_csv => false,
        :import_works_as_csv => false,
        :import_from_pros => false,
        :manage_opportunities => false,
        :max_account_users => 4,
        :max_ipi_codes => "Max Ipi Codes"
      ),
      AccountFeature.create!(
        :account_type => "Account Type",
        :max_recordings => 1,
        :enable_catalogs => false,
        :max_catalogs => 2,
        :max_catalog_users => 3,
        :multiply_recordings_on_works => false,
        :export_works_as_csv => false,
        :import_works_as_csv => false,
        :import_from_pros => false,
        :manage_opportunities => false,
        :max_account_users => 4,
        :max_ipi_codes => "Max Ipi Codes"
      )
    ])
  end

  it "renders a list of account_features" do
    render
    assert_select "tr>td", :text => "Account Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Max Ipi Codes".to_s, :count => 2
  end
end
