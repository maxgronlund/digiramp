require 'rails_helper'

RSpec.describe "issue_events/edit", :type => :view do
  before(:each) do
    @issue_event = assign(:issue_event, IssueEvent.create!(
      :title => "MyString",
      :data => "MyText",
      :subject => nil
    ))
  end

  it "renders the edit issue_event form" do
    render

    assert_select "form[action=?][method=?]", issue_event_path(@issue_event), "post" do

      assert_select "input#issue_event_title[name=?]", "issue_event[title]"

      assert_select "textarea#issue_event_data[name=?]", "issue_event[data]"

      assert_select "input#issue_event_subject_id[name=?]", "issue_event[subject_id]"
    end
  end
end
