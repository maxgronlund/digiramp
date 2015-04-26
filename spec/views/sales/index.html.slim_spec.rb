require 'rails_helper'

RSpec.describe "sales/index", :type => :view do
  before(:each) do
    assign(:sales, [
      Sale.create!(
        :email => "Email",
        :guid => "Guid",
        :product => nil
      ),
      Sale.create!(
        :email => "Email",
        :guid => "Guid",
        :product => nil
      )
    ])
  end

  it "renders a list of sales" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
