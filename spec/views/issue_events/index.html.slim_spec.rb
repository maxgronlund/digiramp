require 'rails_helper'

RSpec.describe "issue_events/index", :type => :view do
  before(:each) do
    assign(:issue_events, [
      IssueEvent.create!(
        :title => "Title",
        :data => "MyText",
        :subject => nil
      ),
      IssueEvent.create!(
        :title => "Title",
        :data => "MyText",
        :subject => nil
      )
    ])
  end

  it "renders a list of issue_events" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
