require 'rails_helper'

RSpec.describe "pro_user_subscribtions/index", :type => :view do
  before(:each) do
    assign(:pro_user_subscribtions, [
      ProUserSubscribtion.create!(
        :email => "Email",
        :user => nil,
        :account => nil
      ),
      ProUserSubscribtion.create!(
        :email => "Email",
        :user => nil,
        :account => nil
      )
    ])
  end

  it "renders a list of pro_user_subscribtions" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
