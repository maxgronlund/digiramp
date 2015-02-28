require 'rails_helper'

RSpec.describe "cms_profiles/index", :type => :view do
  before(:each) do
    assign(:cms_profiles, [
      CmsProfile.create!(
        :user => nil
      ),
      CmsProfile.create!(
        :user => nil
      )
    ])
  end

  it "renders a list of cms_profiles" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
