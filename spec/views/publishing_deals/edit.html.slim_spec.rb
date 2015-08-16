require 'rails_helper'

RSpec.describe "publishing_deals/edit", type: :view do
  before(:each) do
    @publishing_deal = assign(:publishing_deal, PublishingDeal.create!(
      :publisher => nil,
      :title => "MyString",
      :document => nil
    ))
  end

  it "renders the edit publishing_deal form" do
    render

    assert_select "form[action=?][method=?]", publishing_deal_path(@publishing_deal), "post" do

      assert_select "input#publishing_deal_publisher_id[name=?]", "publishing_deal[publisher_id]"

      assert_select "input#publishing_deal_title[name=?]", "publishing_deal[title]"

      assert_select "input#publishing_deal_document_id[name=?]", "publishing_deal[document_id]"
    end
  end
end
