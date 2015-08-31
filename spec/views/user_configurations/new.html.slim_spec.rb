require 'rails_helper'

RSpec.describe "user_configurations/new", type: :view do
  before(:each) do
    assign(:user_configuration, UserConfiguration.new(
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
    ))
  end

  it "renders new user_configuration form" do
    render

    assert_select "form[action=?][method=?]", user_configurations_path, "post" do

      assert_select "input#user_configuration_user_id[name=?]", "user_configuration[user_id]"

      assert_select "input#user_configuration_i_want_to_upload_music[name=?]", "user_configuration[i_want_to_upload_music]"

      assert_select "input#user_configuration_i_am_looking_for_a_publisher[name=?]", "user_configuration[i_am_looking_for_a_publisher]"

      assert_select "input#user_configuration_register_me_as_a_publisher[name=?]", "user_configuration[register_me_as_a_publisher]"

      assert_select "input#user_configuration_i_have_a_publisher[name=?]", "user_configuration[i_have_a_publisher]"

      assert_select "input#user_configuration_i_want_to_sell_goods[name=?]", "user_configuration[i_want_to_sell_goods]"

      assert_select "input#user_configuration_i_want_to_sell_services[name=?]", "user_configuration[i_want_to_sell_services]"

      assert_select "input#user_configuration_i_want_to_collaborate[name=?]", "user_configuration[i_want_to_collaborate]"

      assert_select "input#user_configuration_i_want_to_receive_money_directly[name=?]", "user_configuration[i_want_to_receive_money_directly]"

      assert_select "input#user_configuration_i_want_to_manage_users_and_catalogs[name=?]", "user_configuration[i_want_to_manage_users_and_catalogs]"

      assert_select "input#user_configuration_dont_ask_me_again[name=?]", "user_configuration[dont_ask_me_again]"

      assert_select "input#user_configuration_configured[name=?]", "user_configuration[configured]"
    end
  end
end
