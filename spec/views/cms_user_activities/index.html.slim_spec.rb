require 'rails_helper'

RSpec.describe "cms_user_activities/index", :type => :view do
  before(:each) do
    assign(:cms_user_activities, [
      CmsUserActivity.create!(
        :user => nil
      ),
      CmsUserActivity.create!(
        :user => nil
      )
    ])
  end

  it "renders a list of cms_user_activities" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
