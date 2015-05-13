require 'rails_helper'

RSpec.describe "sales/coupon_batches/show", :type => :view do
  before(:each) do
    @sales_coupon_batch = assign(:sales_coupon_batch, Sales::CouponBatch.create!(
      :title => "Title",
      :body => "MyText",
      :email => "Email",
      :created_by => "Created By"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Created By/)
  end
end
