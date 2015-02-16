require 'rails_helper'

RSpec.describe "cms_social_links/edit", :type => :view do
  before(:each) do
    @cms_social_link = assign(:cms_social_link, CmsSocialLink.create!(
      :position => 1,
      :user => nil
    ))
  end

  it "renders the edit cms_social_link form" do
    render

    assert_select "form[action=?][method=?]", cms_social_link_path(@cms_social_link), "post" do

      assert_select "input#cms_social_link_position[name=?]", "cms_social_link[position]"

      assert_select "input#cms_social_link_user_id[name=?]", "cms_social_link[user_id]"
    end
  end
end
