require 'rails_helper'

RSpec.describe "email_groups/index", :type => :view do
  before(:each) do
    assign(:email_groups, [
      EmailGroup.create!(
        :title => "Title",
        :body => "MyText"
      ),
      EmailGroup.create!(
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of email_groups" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
