require 'rails_helper'

RSpec.describe "admin/legal_tags/edit", type: :view do
  before(:each) do
    @admin_legal_tag = assign(:admin_legal_tag, Admin::LegalTag.create!(
      :title => "MyString",
      :body => "MyString"
    ))
  end

  it "renders the edit admin_legal_tag form" do
    render

    assert_select "form[action=?][method=?]", admin_legal_tag_path(@admin_legal_tag), "post" do

      assert_select "input#admin_legal_tag_title[name=?]", "admin_legal_tag[title]"

      assert_select "input#admin_legal_tag_body[name=?]", "admin_legal_tag[body]"
    end
  end
end
