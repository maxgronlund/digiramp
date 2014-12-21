require 'rails_helper'

RSpec.describe "helps/edit", :type => :view do
  before(:each) do
    @help = assign(:help, Help.create!(
      :identifier => "MyString",
      :button => "MyString",
      :title => "MyString",
      :body => "MyText",
      :snippet => "MyText"
    ))
  end

  it "renders the edit help form" do
    render

    assert_select "form[action=?][method=?]", help_path(@help), "post" do

      assert_select "input#help_identifier[name=?]", "help[identifier]"

      assert_select "input#help_button[name=?]", "help[button]"

      assert_select "input#help_title[name=?]", "help[title]"

      assert_select "textarea#help_body[name=?]", "help[body]"

      assert_select "textarea#help_snippet[name=?]", "help[snippet]"
    end
  end
end
