require 'rails_helper'

RSpec.describe "user_configurations/show", type: :view do
  before(:each) do
    @user_configuration = assign(:user_configuration, UserConfiguration.create!(
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
