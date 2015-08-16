require 'rails_helper'

RSpec.describe "publishers/index", type: :view do
  before(:each) do
    assign(:publishers, [
      Publisher.create!(
        :user => "",
        :email, => "Email,",
        :phone_number, => "Phone Number,",
        :ipi_code, => "Ipi Code,",
        :cae_code => "Cae Code",
        :uuid => "",
        :pro_affiliation => "",
        :status => 1
      ),
      Publisher.create!(
        :user => "",
        :email, => "Email,",
        :phone_number, => "Phone Number,",
        :ipi_code, => "Ipi Code,",
        :cae_code => "Cae Code",
        :uuid => "",
        :pro_affiliation => "",
        :status => 1
      )
    ])
  end

  it "renders a list of publishers" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Email,".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number,".to_s, :count => 2
    assert_select "tr>td", :text => "Ipi Code,".to_s, :count => 2
    assert_select "tr>td", :text => "Cae Code".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
