require 'rails_helper'

RSpec.describe "system_settings/new", :type => :view do
  before(:each) do
    assign(:system_setting, SystemSetting.new(
      :recording_artwork_id => 1,
      :user_avatar_id => 1,
      :company_logo_id => 1
    ))
  end

  it "renders new system_setting form" do
    render

    assert_select "form[action=?][method=?]", system_settings_path, "post" do

      assert_select "input#system_setting_recording_artwork_id[name=?]", "system_setting[recording_artwork_id]"

      assert_select "input#system_setting_user_avatar_id[name=?]", "system_setting[user_avatar_id]"

      assert_select "input#system_setting_company_logo_id[name=?]", "system_setting[company_logo_id]"
    end
  end
end
