require 'rails_helper'

RSpec.describe "cms_profiles/new", :type => :view do
  before(:each) do
    assign(:cms_profile, CmsProfile.new(
      :user => nil
    ))
  end

  it "renders new cms_profile form" do
    render

    assert_select "form[action=?][method=?]", cms_profiles_path, "post" do

      assert_select "input#cms_profile_user_id[name=?]", "cms_profile[user_id]"
    end
  end
end
