require 'rails_helper'

RSpec.describe "coupons/show", :type => :view do
  before(:each) do
    @coupon = assign(:coupon, Coupon.create!(
      :percent_off => 1,
      :duration => "Duration",
      :duration_in_month => 2,
      :stripe_id => "Stripe",
      :currency => "Currency",
      :max_redemptions => 3,
      :metadata => "MyText",
      :user => nil,
      :account => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Duration/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Stripe/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
