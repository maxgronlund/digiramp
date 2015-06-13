require 'rails_helper'

RSpec.describe "admin/mandrill_accounts/show", type: :view do
  before(:each) do
    @admin_mandrill_account = assign(:admin_mandrill_account, Admin::MandrillAccount.create!(
      :account => nil,
      :notes => "Notes",
      :custom_quota => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/1/)
  end
end
