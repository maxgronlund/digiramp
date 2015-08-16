require 'rails_helper'

RSpec.describe "publishing_deals/new", type: :view do
  before(:each) do
    assign(:publishing_deal, PublishingDeal.new(
      :publisher => nil,
      :title => "MyString",
      :document => nil
    ))
  end

  it "renders new publishing_deal form" do
    render

    assert_select "form[action=?][method=?]", publishing_deals_path, "post" do

      assert_select "input#publishing_deal_publisher_id[name=?]", "publishing_deal[publisher_id]"

      assert_select "input#publishing_deal_title[name=?]", "publishing_deal[title]"

      assert_select "input#publishing_deal_document_id[name=?]", "publishing_deal[document_id]"
    end
  end
end
