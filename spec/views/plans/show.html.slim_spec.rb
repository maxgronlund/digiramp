require 'rails_helper'

RSpec.describe "plans/show", :type => :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :stripe_id => "Stripe",
      :name => "Name",
      :description => "MyText",
      :amount => 1,
      :interval => "Interval",
      :published => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Stripe/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Interval/)
    expect(rendered).to match(/false/)
  end
end
