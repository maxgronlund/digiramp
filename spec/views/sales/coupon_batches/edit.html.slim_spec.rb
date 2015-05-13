require 'rails_helper'

RSpec.describe "sales/coupon_batches/edit", :type => :view do
  before(:each) do
    @sales_coupon_batch = assign(:sales_coupon_batch, Sales::CouponBatch.create!(
      :title => "MyString",
      :body => "MyText",
      :email => "MyString",
      :created_by => "MyString"
    ))
  end

  it "renders the edit sales_coupon_batch form" do
    render

    assert_select "form[action=?][method=?]", sales_coupon_batch_path(@sales_coupon_batch), "post" do

      assert_select "input#sales_coupon_batch_title[name=?]", "sales_coupon_batch[title]"

      assert_select "textarea#sales_coupon_batch_body[name=?]", "sales_coupon_batch[body]"

      assert_select "input#sales_coupon_batch_email[name=?]", "sales_coupon_batch[email]"

      assert_select "input#sales_coupon_batch_created_by[name=?]", "sales_coupon_batch[created_by]"
    end
  end
end
