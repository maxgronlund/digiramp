require 'rails_helper'

RSpec.describe "cms_comments/new", :type => :view do
  before(:each) do
    assign(:cms_comment, CmsComment.new(
      :position => 1
    ))
  end

  it "renders new cms_comment form" do
    render

    assert_select "form[action=?][method=?]", cms_comments_path, "post" do

      assert_select "input#cms_comment_position[name=?]", "cms_comment[position]"
    end
  end
end
