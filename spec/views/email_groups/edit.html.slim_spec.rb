require 'rails_helper'

RSpec.describe "email_groups/edit", :type => :view do
  before(:each) do
    @email_group = assign(:email_group, EmailGroup.create!(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders the edit email_group form" do
    render

    assert_select "form[action=?][method=?]", email_group_path(@email_group), "post" do

      assert_select "input#email_group_title[name=?]", "email_group[title]"

      assert_select "textarea#email_group_body[name=?]", "email_group[body]"
    end
  end
end
