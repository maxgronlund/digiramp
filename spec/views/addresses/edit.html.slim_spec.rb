require 'rails_helper'

RSpec.describe "addresses/edit", type: :view do
  before(:each) do
    @address = assign(:address, Address.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :address_line_1 => "MyText",
      :address_line_2 => "MyText",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString",
      :addressable => nil
    ))
  end

  it "renders the edit address form" do
    render

    assert_select "form[action=?][method=?]", address_path(@address), "post" do

      assert_select "input#address_first_name[name=?]", "address[first_name]"

      assert_select "input#address_last_name[name=?]", "address[last_name]"

      assert_select "textarea#address_address_line_1[name=?]", "address[address_line_1]"

      assert_select "textarea#address_address_line_2[name=?]", "address[address_line_2]"

      assert_select "input#address_city[name=?]", "address[city]"

      assert_select "input#address_state[name=?]", "address[state]"

      assert_select "input#address_country[name=?]", "address[country]"

      assert_select "input#address_addressable_id[name=?]", "address[addressable_id]"
    end
  end
end
