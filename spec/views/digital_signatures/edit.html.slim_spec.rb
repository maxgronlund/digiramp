require 'rails_helper'

RSpec.describe "digital_signatures/edit", type: :view do
  before(:each) do
    @digital_signature = assign(:digital_signature, DigitalSignature.create!(
      :uuid => "MyString",
      :user => nil,
      :account => nil,
      :document => nil,
      :image => "MyString"
    ))
  end

  it "renders the edit digital_signature form" do
    render

    assert_select "form[action=?][method=?]", digital_signature_path(@digital_signature), "post" do

      assert_select "input#digital_signature_uuid[name=?]", "digital_signature[uuid]"

      assert_select "input#digital_signature_user_id[name=?]", "digital_signature[user_id]"

      assert_select "input#digital_signature_account_id[name=?]", "digital_signature[account_id]"

      assert_select "input#digital_signature_document_id[name=?]", "digital_signature[document_id]"

      assert_select "input#digital_signature_image[name=?]", "digital_signature[image]"
    end
  end
end
