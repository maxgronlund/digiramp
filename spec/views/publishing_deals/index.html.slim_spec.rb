require 'rails_helper'

RSpec.describe "publishing_deals/index", type: :view do
  before(:each) do
    assign(:publishing_deals, [
      PublishingDeal.create!(
        :publisher => nil,
        :title => "Title",
        :document => nil
      ),
      PublishingDeal.create!(
        :publisher => nil,
        :title => "Title",
        :document => nil
      )
    ])
  end

  it "renders a list of publishing_deals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
