require 'rails_helper'

RSpec.describe "publishing_deals/show", type: :view do
  before(:each) do
    @publishing_deal = assign(:publishing_deal, PublishingDeal.create!(
      :publisher => nil,
      :title => "Title",
      :document => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
