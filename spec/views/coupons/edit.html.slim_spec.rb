require 'rails_helper'

RSpec.describe "coupons/edit", :type => :view do
  before(:each) do
    @coupon = assign(:coupon, Coupon.create!(
      :percent_off => 1,
      :duration => "MyString",
      :duration_in_month => 1,
      :stripe_id => "MyString",
      :currency => "MyString",
      :max_redemptions => 1,
      :metadata => "MyText",
      :user => nil,
      :account => nil
    ))
  end

  it "renders the edit coupon form" do
    render

    assert_select "form[action=?][method=?]", coupon_path(@coupon), "post" do

      assert_select "input#coupon_percent_off[name=?]", "coupon[percent_off]"

      assert_select "input#coupon_duration[name=?]", "coupon[duration]"

      assert_select "input#coupon_duration_in_month[name=?]", "coupon[duration_in_month]"

      assert_select "input#coupon_stripe_id[name=?]", "coupon[stripe_id]"

      assert_select "input#coupon_currency[name=?]", "coupon[currency]"

      assert_select "input#coupon_max_redemptions[name=?]", "coupon[max_redemptions]"

      assert_select "textarea#coupon_metadata[name=?]", "coupon[metadata]"

      assert_select "input#coupon_user_id[name=?]", "coupon[user_id]"

      assert_select "input#coupon_account_id[name=?]", "coupon[account_id]"
    end
  end
end
