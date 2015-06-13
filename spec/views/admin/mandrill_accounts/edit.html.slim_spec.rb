require 'rails_helper'

RSpec.describe "admin/mandrill_accounts/edit", type: :view do
  before(:each) do
    @admin_mandrill_account = assign(:admin_mandrill_account, Admin::MandrillAccount.create!(
      :account => nil,
      :notes => "MyString",
      :custom_quota => 1
    ))
  end

  it "renders the edit admin_mandrill_account form" do
    render

    assert_select "form[action=?][method=?]", admin_mandrill_account_path(@admin_mandrill_account), "post" do

      assert_select "input#admin_mandrill_account_account_id[name=?]", "admin_mandrill_account[account_id]"

      assert_select "input#admin_mandrill_account_notes[name=?]", "admin_mandrill_account[notes]"

      assert_select "input#admin_mandrill_account_custom_quota[name=?]", "admin_mandrill_account[custom_quota]"
    end
  end
end
