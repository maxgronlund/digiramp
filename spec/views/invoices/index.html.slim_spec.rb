require 'rails_helper'

RSpec.describe "invoices/index", :type => :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        :stripe_id => "Stripe",
        :stripe_object => "Stripe Object",
        :livemode => false,
        :amount_due => 1,
        :attempted => false,
        :closed => false,
        :currency => "Currency",
        :stripe_customer_id => "Stripe Customer",
        :forgiven => false,
        :lines => "MyText",
        :paid => false,
        :starting_balance => 2,
        :subtotal => 3,
        :total => 4,
        :application_fee => 5,
        :charge => "Charge",
        :description => "Description",
        :discount => "MyText",
        :ending_balance => 6,
        :receipt_number => "Receipt Number",
        :statement_descriptor => "Statement Descriptor",
        :subscription_id => "Subscription",
        :metadata => "MyText",
        :tax => 7,
        :tax_percent => 8,
        :user => nil,
        :account => nil
      ),
      Invoice.create!(
        :stripe_id => "Stripe",
        :stripe_object => "Stripe Object",
        :livemode => false,
        :amount_due => 1,
        :attempted => false,
        :closed => false,
        :currency => "Currency",
        :stripe_customer_id => "Stripe Customer",
        :forgiven => false,
        :lines => "MyText",
        :paid => false,
        :starting_balance => 2,
        :subtotal => 3,
        :total => 4,
        :application_fee => 5,
        :charge => "Charge",
        :description => "Description",
        :discount => "MyText",
        :ending_balance => 6,
        :receipt_number => "Receipt Number",
        :statement_descriptor => "Statement Descriptor",
        :subscription_id => "Subscription",
        :metadata => "MyText",
        :tax => 7,
        :tax_percent => 8,
        :user => nil,
        :account => nil
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", :text => "Stripe".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Object".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Customer".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Charge".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Receipt Number".to_s, :count => 2
    assert_select "tr>td", :text => "Statement Descriptor".to_s, :count => 2
    assert_select "tr>td", :text => "Subscription".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
