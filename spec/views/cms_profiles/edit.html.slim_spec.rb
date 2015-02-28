require 'rails_helper'

RSpec.describe "cms_profiles/edit", :type => :view do
  before(:each) do
    @cms_profile = assign(:cms_profile, CmsProfile.create!(
      :user => nil
    ))
  end

  it "renders the edit cms_profile form" do
    render

    assert_select "form[action=?][method=?]", cms_profile_path(@cms_profile), "post" do

      assert_select "input#cms_profile_user_id[name=?]", "cms_profile[user_id]"
    end
  end
end
