require 'rails_helper'

RSpec.describe "connections/index", :type => :view do
  before(:each) do
    assign(:connections, [
      Connection.create!(
        :user => nil,
        :connection_id => 1,
        :approved => false,
        :message => "MyText"
      ),
      Connection.create!(
        :user => nil,
        :connection_id => 1,
        :approved => false,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of connections" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
