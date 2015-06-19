require 'rails_helper'

RSpec.describe "admin/terms/new", type: :view do
  before(:each) do
    assign(:admin_term, Admin::Term.new(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new admin_term form" do
    render

    assert_select "form[action=?][method=?]", admin_terms_path, "post" do

      assert_select "input#admin_term_title[name=?]", "admin_term[title]"

      assert_select "textarea#admin_term_body[name=?]", "admin_term[body]"
    end
  end
end
