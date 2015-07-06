require 'rails_helper'

RSpec.describe "digital_signatures/show", type: :view do
  before(:each) do
    @digital_signature = assign(:digital_signature, DigitalSignature.create!(
      :uuid => "Uuid",
      :user => nil,
      :account => nil,
      :document => nil,
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Image/)
  end
end
