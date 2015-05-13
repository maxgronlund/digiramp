require 'rails_helper'

RSpec.describe "sales/coupon_batches/new", :type => :view do
  before(:each) do
    assign(:sales_coupon_batch, Sales::CouponBatch.new(
      :title => "MyString",
      :body => "MyText",
      :email => "MyString",
      :created_by => "MyString"
    ))
  end

  it "renders new sales_coupon_batch form" do
    render

    assert_select "form[action=?][method=?]", sales_coupon_batches_path, "post" do

      assert_select "input#sales_coupon_batch_title[name=?]", "sales_coupon_batch[title]"

      assert_select "textarea#sales_coupon_batch_body[name=?]", "sales_coupon_batch[body]"

      assert_select "input#sales_coupon_batch_email[name=?]", "sales_coupon_batch[email]"

      assert_select "input#sales_coupon_batch_created_by[name=?]", "sales_coupon_batch[created_by]"
    end
  end
end
