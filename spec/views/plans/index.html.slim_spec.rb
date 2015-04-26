require 'rails_helper'

RSpec.describe "plans/index", :type => :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :stripe_id => "Stripe",
        :name => "Name",
        :description => "MyText",
        :amount => 1,
        :interval => "Interval",
        :published => false
      ),
      Plan.create!(
        :stripe_id => "Stripe",
        :name => "Name",
        :description => "MyText",
        :amount => 1,
        :interval => "Interval",
        :published => false
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => "Stripe".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Interval".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
