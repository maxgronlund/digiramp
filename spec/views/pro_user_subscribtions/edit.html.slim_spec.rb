require 'rails_helper'

RSpec.describe "pro_user_subscribtions/edit", :type => :view do
  before(:each) do
    @pro_user_subscribtion = assign(:pro_user_subscribtion, ProUserSubscribtion.create!(
      :email => "MyString",
      :user => nil,
      :account => nil
    ))
  end

  it "renders the edit pro_user_subscribtion form" do
    render

    assert_select "form[action=?][method=?]", pro_user_subscribtion_path(@pro_user_subscribtion), "post" do

      assert_select "input#pro_user_subscribtion_email[name=?]", "pro_user_subscribtion[email]"

      assert_select "input#pro_user_subscribtion_user_id[name=?]", "pro_user_subscribtion[user_id]"

      assert_select "input#pro_user_subscribtion_account_id[name=?]", "pro_user_subscribtion[account_id]"
    end
  end
end
