require 'rails_helper'

RSpec.describe "cms_social_links/new", :type => :view do
  before(:each) do
    assign(:cms_social_link, CmsSocialLink.new(
      :position => 1,
      :user => nil
    ))
  end

  it "renders new cms_social_link form" do
    render

    assert_select "form[action=?][method=?]", cms_social_links_path, "post" do

      assert_select "input#cms_social_link_position[name=?]", "cms_social_link[position]"

      assert_select "input#cms_social_link_user_id[name=?]", "cms_social_link[user_id]"
    end
  end
end
