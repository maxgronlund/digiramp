require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :address_line_1 => "MyText",
        :address_line_2 => "MyText",
        :city => "City",
        :state => "State",
        :country => "Country",
        :addressable => nil
      ),
      Address.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :address_line_1 => "MyText",
        :address_line_2 => "MyText",
        :city => "City",
        :state => "State",
        :country => "Country",
        :addressable => nil
      )
    ])
  end

  it "renders a list of addresses" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
