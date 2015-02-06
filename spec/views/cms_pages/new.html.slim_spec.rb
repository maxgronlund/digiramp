require 'rails_helper'

RSpec.describe "cms_pages/new", :type => :view do
  before(:each) do
    assign(:cms_page, CmsPage.new(
      :user => nil,
      :title => "MyString"
    ))
  end

  it "renders new cms_page form" do
    render

    assert_select "form[action=?][method=?]", cms_pages_path, "post" do

      assert_select "input#cms_page_user_id[name=?]", "cms_page[user_id]"

      assert_select "input#cms_page_title[name=?]", "cms_page[title]"
    end
  end
end
