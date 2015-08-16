require 'rails_helper'

RSpec.describe "publishing_agreements/new", type: :view do
  before(:each) do
    assign(:publishing_agreement, PublishingAgreement.new(
      :publisher => nil,
      :title => "MyString",
      :document => nil
    ))
  end

  it "renders new publishing_agreement form" do
    render

    assert_select "form[action=?][method=?]", publishing_agreements_path, "post" do

      assert_select "input#publishing_agreement_publisher_id[name=?]", "publishing_agreement[publisher_id]"

      assert_select "input#publishing_agreement_title[name=?]", "publishing_agreement[title]"

      assert_select "input#publishing_agreement_document_id[name=?]", "publishing_agreement[document_id]"
    end
  end
end
