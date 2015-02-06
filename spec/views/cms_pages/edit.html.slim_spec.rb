require 'rails_helper'

RSpec.describe "cms_pages/edit", :type => :view do
  before(:each) do
    @cms_page = assign(:cms_page, CmsPage.create!(
      :user => nil,
      :title => "MyString"
    ))
  end

  it "renders the edit cms_page form" do
    render

    assert_select "form[action=?][method=?]", cms_page_path(@cms_page), "post" do

      assert_select "input#cms_page_user_id[name=?]", "cms_page[user_id]"

      assert_select "input#cms_page_title[name=?]", "cms_page[title]"
    end
  end
end
