require 'rails_helper'

RSpec.describe "sales/coupon_batches/index", :type => :view do
  before(:each) do
    assign(:sales_coupon_batches, [
      Sales::CouponBatch.create!(
        :title => "Title",
        :body => "MyText",
        :email => "Email",
        :created_by => "Created By"
      ),
      Sales::CouponBatch.create!(
        :title => "Title",
        :body => "MyText",
        :email => "Email",
        :created_by => "Created By"
      )
    ])
  end

  it "renders a list of sales/coupon_batches" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Created By".to_s, :count => 2
  end
end
