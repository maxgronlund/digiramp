require 'rails_helper'

RSpec.describe "invoices/show", :type => :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Stripe/)
    expect(rendered).to match(/Stripe Object/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/Stripe Customer/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Charge/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Receipt Number/)
    expect(rendered).to match(/Statement Descriptor/)
    expect(rendered).to match(/Subscription/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
