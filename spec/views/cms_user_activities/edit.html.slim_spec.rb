require 'rails_helper'

RSpec.describe "cms_user_activities/edit", :type => :view do
  before(:each) do
    @cms_user_activity = assign(:cms_user_activity, CmsUserActivity.create!(
      :user => nil
    ))
  end

  it "renders the edit cms_user_activity form" do
    render

    assert_select "form[action=?][method=?]", cms_user_activity_path(@cms_user_activity), "post" do

      assert_select "input#cms_user_activity_user_id[name=?]", "cms_user_activity[user_id]"
    end
  end
end
