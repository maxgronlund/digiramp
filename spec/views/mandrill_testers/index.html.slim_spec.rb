require 'rails_helper'

RSpec.describe "mandrill_testers/index", type: :view do
  before(:each) do
    assign(:mandrill_testers, [
      MandrillTester.create!(
        :email => "Email",
        :subject => "Subject",
        :message => "MyText"
      ),
      MandrillTester.create!(
        :email => "Email",
        :subject => "Subject",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of mandrill_testers" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
