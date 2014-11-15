require 'rails_helper'

RSpec.describe "system_settings/show", :type => :view do
  before(:each) do
    @system_setting = assign(:system_setting, SystemSetting.create!(
      :recording_artwork_id => 1,
      :user_avatar_id => 2,
      :company_logo_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
