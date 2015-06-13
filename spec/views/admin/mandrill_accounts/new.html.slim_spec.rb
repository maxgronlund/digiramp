require 'rails_helper'

RSpec.describe "admin/mandrill_accounts/new", type: :view do
  before(:each) do
    assign(:admin_mandrill_account, Admin::MandrillAccount.new(
      :account => nil,
      :notes => "MyString",
      :custom_quota => 1
    ))
  end

  it "renders new admin_mandrill_account form" do
    render

    assert_select "form[action=?][method=?]", admin_mandrill_accounts_path, "post" do

      assert_select "input#admin_mandrill_account_account_id[name=?]", "admin_mandrill_account[account_id]"

      assert_select "input#admin_mandrill_account_notes[name=?]", "admin_mandrill_account[notes]"

      assert_select "input#admin_mandrill_account_custom_quota[name=?]", "admin_mandrill_account[custom_quota]"
    end
  end
end
