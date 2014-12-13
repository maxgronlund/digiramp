require 'rails_helper'

RSpec.describe "digiramp_emails/index", :type => :view do
  before(:each) do
    assign(:digiramp_emails, [
      DigirampEmail.create!(
        :email_group => nil,
        :email_layout => nil,
        :title => "Title",
        :body => "MyText",
        :recipients => "MyText"
      ),
      DigirampEmail.create!(
        :email_group => nil,
        :email_layout => nil,
        :title => "Title",
        :body => "MyText",
        :recipients => "MyText"
      )
    ])
  end

  it "renders a list of digiramp_emails" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
