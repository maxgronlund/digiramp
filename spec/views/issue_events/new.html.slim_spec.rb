require 'rails_helper'

RSpec.describe "issue_events/new", :type => :view do
  before(:each) do
    assign(:issue_event, IssueEvent.new(
      :title => "MyString",
      :data => "MyText",
      :subject => nil
    ))
  end

  it "renders new issue_event form" do
    render

    assert_select "form[action=?][method=?]", issue_events_path, "post" do

      assert_select "input#issue_event_title[name=?]", "issue_event[title]"

      assert_select "textarea#issue_event_data[name=?]", "issue_event[data]"

      assert_select "input#issue_event_subject_id[name=?]", "issue_event[subject_id]"
    end
  end
end
