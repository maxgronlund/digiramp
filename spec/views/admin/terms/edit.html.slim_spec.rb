require 'rails_helper'

RSpec.describe "admin/terms/edit", type: :view do
  before(:each) do
    @admin_term = assign(:admin_term, Admin::Term.create!(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit admin_term form" do
    render

    assert_select "form[action=?][method=?]", admin_term_path(@admin_term), "post" do

      assert_select "input#admin_term_title[name=?]", "admin_term[title]"

      assert_select "textarea#admin_term_body[name=?]", "admin_term[body]"
    end
  end
end
