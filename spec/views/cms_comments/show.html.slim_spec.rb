require 'rails_helper'

RSpec.describe "cms_comments/show", :type => :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, CmsComment.create!(
      :position => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
