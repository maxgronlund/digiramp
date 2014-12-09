require 'rails_helper'

RSpec.describe "connections/show", :type => :view do
  before(:each) do
    @connection = assign(:connection, Connection.create!(
      :user => nil,
      :connection_id => 1,
      :approved => false,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
  end
end
