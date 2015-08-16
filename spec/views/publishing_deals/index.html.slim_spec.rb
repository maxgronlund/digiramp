require 'rails_helper'

RSpec.describe "publishing_agreements/index", type: :view do
  before(:each) do
    assign(:publishing_agreements, [
      PublishingAgreement.create!(
        :publisher => nil,
        :title => "Title",
        :document => nil
      ),
      PublishingAgreement.create!(
        :publisher => nil,
        :title => "Title",
        :document => nil
      )
    ])
  end

  it "renders a list of publishing_agreements" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
