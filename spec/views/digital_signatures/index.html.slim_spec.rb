require 'rails_helper'

RSpec.describe "digital_signatures/index", type: :view do
  before(:each) do
    assign(:digital_signatures, [
      DigitalSignature.create!(
        :uuid => "Uuid",
        :user => nil,
        :account => nil,
        :document => nil,
        :image => "Image"
      ),
      DigitalSignature.create!(
        :uuid => "Uuid",
        :user => nil,
        :account => nil,
        :document => nil,
        :image => "Image"
      )
    ])
  end

  it "renders a list of digital_signatures" do
    render
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
