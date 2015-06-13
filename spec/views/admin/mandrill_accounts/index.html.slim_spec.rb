require 'rails_helper'

RSpec.describe "admin/mandrill_accounts/index", type: :view do
  before(:each) do
    assign(:admin_mandrill_accounts, [
      Admin::MandrillAccount.create!(
        :account => nil,
        :notes => "Notes",
        :custom_quota => 1
      ),
      Admin::MandrillAccount.create!(
        :account => nil,
        :notes => "Notes",
        :custom_quota => 1
      )
    ])
  end

  it "renders a list of admin/mandrill_accounts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
