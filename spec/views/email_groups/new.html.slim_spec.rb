require 'rails_helper'

RSpec.describe "email_groups/new", :type => :view do
  before(:each) do
    assign(:email_group, EmailGroup.new(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new email_group form" do
    render

    assert_select "form[action=?][method=?]", email_groups_path, "post" do

      assert_select "input#email_group_title[name=?]", "email_group[title]"

      assert_select "textarea#email_group_body[name=?]", "email_group[body]"
    end
  end
end
