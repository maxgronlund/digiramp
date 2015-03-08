require 'rails_helper'

RSpec.describe "contracts/show", :type => :view do
  before(:each) do
    @contract = assign(:contract, Contract.create!(
      :title => "Title",
      :subject => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
