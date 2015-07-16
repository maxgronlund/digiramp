require 'rails_helper'

RSpec.describe "admin/legal_tags/new", type: :view do
  before(:each) do
    assign(:admin_legal_tag, Admin::LegalTag.new(
      :title => "MyString",
      :body => "MyString"
    ))
  end

  it "renders new admin_legal_tag form" do
    render

    assert_select "form[action=?][method=?]", admin_legal_tags_path, "post" do

      assert_select "input#admin_legal_tag_title[name=?]", "admin_legal_tag[title]"

      assert_select "input#admin_legal_tag_body[name=?]", "admin_legal_tag[body]"
    end
  end
end
