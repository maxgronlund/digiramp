require 'rails_helper'

RSpec.describe "sales/edit", :type => :view do
  before(:each) do
    @sale = assign(:sale, Sale.create!(
      :email => "MyString",
      :guid => "MyString",
      :product => nil
    ))
  end

  it "renders the edit sale form" do
    render

    assert_select "form[action=?][method=?]", sale_path(@sale), "post" do

      assert_select "input#sale_email[name=?]", "sale[email]"

      assert_select "input#sale_guid[name=?]", "sale[guid]"

      assert_select "input#sale_product_id[name=?]", "sale[product_id]"
    end
  end
end
