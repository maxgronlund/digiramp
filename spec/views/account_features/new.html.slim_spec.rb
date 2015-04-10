require 'rails_helper'

RSpec.describe "account_features/new", :type => :view do
  before(:each) do
    assign(:account_feature, AccountFeature.new(
      :account_type => "MyString",
      :max_recordings => 1,
      :enable_catalogs => false,
      :max_catalogs => 1,
      :max_catalog_users => 1,
      :multiply_recordings_on_works => false,
      :export_works_as_csv => false,
      :import_works_as_csv => false,
      :import_from_pros => false,
      :manage_opportunities => false,
      :max_account_users => 1,
      :max_ipi_codes => "MyString"
    ))
  end

  it "renders new account_feature form" do
    render

    assert_select "form[action=?][method=?]", account_features_path, "post" do

      assert_select "input#account_feature_account_type[name=?]", "account_feature[account_type]"

      assert_select "input#account_feature_max_recordings[name=?]", "account_feature[max_recordings]"

      assert_select "input#account_feature_enable_catalogs[name=?]", "account_feature[enable_catalogs]"

      assert_select "input#account_feature_max_catalogs[name=?]", "account_feature[max_catalogs]"

      assert_select "input#account_feature_max_catalog_users[name=?]", "account_feature[max_catalog_users]"

      assert_select "input#account_feature_multiply_recordings_on_works[name=?]", "account_feature[multiply_recordings_on_works]"

      assert_select "input#account_feature_export_works_as_csv[name=?]", "account_feature[export_works_as_csv]"

      assert_select "input#account_feature_import_works_as_csv[name=?]", "account_feature[import_works_as_csv]"

      assert_select "input#account_feature_import_from_pros[name=?]", "account_feature[import_from_pros]"

      assert_select "input#account_feature_manage_opportunities[name=?]", "account_feature[manage_opportunities]"

      assert_select "input#account_feature_max_account_users[name=?]", "account_feature[max_account_users]"

      assert_select "input#account_feature_max_ipi_codes[name=?]", "account_feature[max_ipi_codes]"
    end
  end
end
