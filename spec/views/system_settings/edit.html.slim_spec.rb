require 'rails_helper'

RSpec.describe "system_settings/edit", :type => :view do
  before(:each) do
    @system_setting = assign(:system_setting, SystemSetting.create!(
      :recording_artwork_id => 1,
      :user_avatar_id => 1,
      :company_logo_id => 1
    ))
  end

  it "renders the edit system_setting form" do
    render

    assert_select "form[action=?][method=?]", system_setting_path(@system_setting), "post" do

      assert_select "input#system_setting_recording_artwork_id[name=?]", "system_setting[recording_artwork_id]"

      assert_select "input#system_setting_user_avatar_id[name=?]", "system_setting[user_avatar_id]"

      assert_select "input#system_setting_company_logo_id[name=?]", "system_setting[company_logo_id]"
    end
  end
end
