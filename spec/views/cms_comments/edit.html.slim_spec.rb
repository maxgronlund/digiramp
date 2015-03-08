require 'rails_helper'

RSpec.describe "cms_comments/edit", :type => :view do
  before(:each) do
    @cms_comment = assign(:cms_comment, CmsComment.create!(
      :position => 1
    ))
  end

  it "renders the edit cms_comment form" do
    render

    assert_select "form[action=?][method=?]", cms_comment_path(@cms_comment), "post" do

      assert_select "input#cms_comment_position[name=?]", "cms_comment[position]"
    end
  end
end
