require 'rails_helper'

RSpec.describe "account_features/show", :type => :view do
  before(:each) do
    @account_feature = assign(:account_feature, AccountFeature.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Account Type/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Max Ipi Codes/)
  end
end
