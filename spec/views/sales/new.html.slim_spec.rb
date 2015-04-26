require 'rails_helper'

RSpec.describe "sales/new", :type => :view do
  before(:each) do
    assign(:sale, Sale.new(
      :email => "MyString",
      :guid => "MyString",
      :product => nil
    ))
  end

  it "renders new sale form" do
    render

    assert_select "form[action=?][method=?]", sales_path, "post" do

      assert_select "input#sale_email[name=?]", "sale[email]"

      assert_select "input#sale_guid[name=?]", "sale[guid]"

      assert_select "input#sale_product_id[name=?]", "sale[product_id]"
    end
  end
end
