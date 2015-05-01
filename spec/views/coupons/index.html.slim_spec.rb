require 'rails_helper'

RSpec.describe "coupons/index", :type => :view do
  before(:each) do
    assign(:coupons, [
      Coupon.create!(
        :percent_off => 1,
        :duration => "Duration",
        :duration_in_month => 2,
        :stripe_id => "Stripe",
        :currency => "Currency",
        :max_redemptions => 3,
        :metadata => "MyText",
        :user => nil,
        :account => nil
      ),
      Coupon.create!(
        :percent_off => 1,
        :duration => "Duration",
        :duration_in_month => 2,
        :stripe_id => "Stripe",
        :currency => "Currency",
        :max_redemptions => 3,
        :metadata => "MyText",
        :user => nil,
        :account => nil
      )
    ])
  end

  it "renders a list of coupons" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Duration".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Stripe".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
