require 'rails_helper'

RSpec.describe "cms_user_activities/new", :type => :view do
  before(:each) do
    assign(:cms_user_activity, CmsUserActivity.new(
      :user => nil
    ))
  end

  it "renders new cms_user_activity form" do
    render

    assert_select "form[action=?][method=?]", cms_user_activities_path, "post" do

      assert_select "input#cms_user_activity_user_id[name=?]", "cms_user_activity[user_id]"
    end
  end
end
