require 'rails_helper'

RSpec.describe "cms_comments/index", :type => :view do
  before(:each) do
    assign(:cms_comments, [
      CmsComment.create!(
        :position => 1
      ),
      CmsComment.create!(
        :position => 1
      )
    ])
  end

  it "renders a list of cms_comments" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
