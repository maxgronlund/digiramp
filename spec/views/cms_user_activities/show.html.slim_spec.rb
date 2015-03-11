require 'rails_helper'

RSpec.describe "cms_user_activities/show", :type => :view do
  before(:each) do
    @cms_user_activity = assign(:cms_user_activity, CmsUserActivity.create!(
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
