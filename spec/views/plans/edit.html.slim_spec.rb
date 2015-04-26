require 'rails_helper'

RSpec.describe "plans/edit", :type => :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :stripe_id => "MyString",
      :name => "MyString",
      :description => "MyText",
      :amount => 1,
      :interval => "MyString",
      :published => false
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input#plan_stripe_id[name=?]", "plan[stripe_id]"

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "textarea#plan_description[name=?]", "plan[description]"

      assert_select "input#plan_amount[name=?]", "plan[amount]"

      assert_select "input#plan_interval[name=?]", "plan[interval]"

      assert_select "input#plan_published[name=?]", "plan[published]"
    end
  end
end
