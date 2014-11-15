require 'rails_helper'

RSpec.describe "system_settings/index", :type => :view do
  before(:each) do
    assign(:system_settings, [
      SystemSetting.create!(
        :recording_artwork_id => 1,
        :user_avatar_id => 2,
        :company_logo_id => 3
      ),
      SystemSetting.create!(
        :recording_artwork_id => 1,
        :user_avatar_id => 2,
        :company_logo_id => 3
      )
    ])
  end

  it "renders a list of system_settings" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
