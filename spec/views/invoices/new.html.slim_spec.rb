require 'rails_helper'

RSpec.describe "invoices/new", :type => :view do
  before(:each) do
    assign(:invoice, Invoice.new(
      :stripe_id => "MyString",
      :stripe_object => "MyString",
      :livemode => false,
      :amount_due => 1,
      :attempted => false,
      :closed => false,
      :currency => "MyString",
      :stripe_customer_id => "MyString",
      :forgiven => false,
      :lines => "MyText",
      :paid => false,
      :starting_balance => 1,
      :subtotal => 1,
      :total => 1,
      :application_fee => 1,
      :charge => "MyString",
      :description => "MyString",
      :discount => "MyText",
      :ending_balance => 1,
      :receipt_number => "MyString",
      :statement_descriptor => "MyString",
      :subscription_id => "MyString",
      :metadata => "MyText",
      :tax => 1,
      :tax_percent => 1,
      :user => nil,
      :account => nil
    ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do

      assert_select "input#invoice_stripe_id[name=?]", "invoice[stripe_id]"

      assert_select "input#invoice_stripe_object[name=?]", "invoice[stripe_object]"

      assert_select "input#invoice_livemode[name=?]", "invoice[livemode]"

      assert_select "input#invoice_amount_due[name=?]", "invoice[amount_due]"

      assert_select "input#invoice_attempted[name=?]", "invoice[attempted]"

      assert_select "input#invoice_closed[name=?]", "invoice[closed]"

      assert_select "input#invoice_currency[name=?]", "invoice[currency]"

      assert_select "input#invoice_stripe_customer_id[name=?]", "invoice[stripe_customer_id]"

      assert_select "input#invoice_forgiven[name=?]", "invoice[forgiven]"

      assert_select "textarea#invoice_lines[name=?]", "invoice[lines]"

      assert_select "input#invoice_paid[name=?]", "invoice[paid]"

      assert_select "input#invoice_starting_balance[name=?]", "invoice[starting_balance]"

      assert_select "input#invoice_subtotal[name=?]", "invoice[subtotal]"

      assert_select "input#invoice_total[name=?]", "invoice[total]"

      assert_select "input#invoice_application_fee[name=?]", "invoice[application_fee]"

      assert_select "input#invoice_charge[name=?]", "invoice[charge]"

      assert_select "input#invoice_description[name=?]", "invoice[description]"

      assert_select "textarea#invoice_discount[name=?]", "invoice[discount]"

      assert_select "input#invoice_ending_balance[name=?]", "invoice[ending_balance]"

      assert_select "input#invoice_receipt_number[name=?]", "invoice[receipt_number]"

      assert_select "input#invoice_statement_descriptor[name=?]", "invoice[statement_descriptor]"

      assert_select "input#invoice_subscription_id[name=?]", "invoice[subscription_id]"

      assert_select "textarea#invoice_metadata[name=?]", "invoice[metadata]"

      assert_select "input#invoice_tax[name=?]", "invoice[tax]"

      assert_select "input#invoice_tax_percent[name=?]", "invoice[tax_percent]"

      assert_select "input#invoice_user_id[name=?]", "invoice[user_id]"

      assert_select "input#invoice_account_id[name=?]", "invoice[account_id]"
    end
  end
end
