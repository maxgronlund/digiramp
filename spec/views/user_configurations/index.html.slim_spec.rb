require 'rails_helper'

RSpec.describe "user_configurations/index", type: :view do
  before(:each) do
    assign(:user_configurations, [
      UserConfiguration.create!(
        :user => nil,
        :i_want_to_upload_music => false,
        :i_am_looking_for_a_publisher => false,
        :register_me_as_a_publisher => false,
        :i_have_a_publisher => false,
        :i_want_to_sell_goods => false,
        :i_want_to_sell_services => false,
        :i_want_to_collaborate => false,
        :i_want_to_receive_money_directly => false,
        :i_want_to_manage_users_and_catalogs => false,
        :dont_ask_me_again => false,
        :configured => false
      ),
      UserConfiguration.create!(
        :user => nil,
        :i_want_to_upload_music => false,
        :i_am_looking_for_a_publisher => false,
        :register_me_as_a_publisher => false,
        :i_have_a_publisher => false,
        :i_want_to_sell_goods => false,
        :i_want_to_sell_services => false,
        :i_want_to_collaborate => false,
        :i_want_to_receive_money_directly => false,
        :i_want_to_manage_users_and_catalogs => false,
        :dont_ask_me_again => false,
        :configured => false
      )
    ])
  end

  it "renders a list of user_configurations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
