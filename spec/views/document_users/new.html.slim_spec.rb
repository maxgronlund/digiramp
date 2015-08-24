require 'rails_helper'

RSpec.describe "document_users/new", type: :view do
  before(:each) do
    assign(:document_user, DocumentUser.new(
      :document => nil,
      :user => nil,
      :account => nil,
      :can_edit => false,
      :should_sign => false,
      :email => "MyString",
      :signature => "MyString",
      :signature_image => "MyString",
      :status => 1
    ))
  end

  it "renders new document_user form" do
    render

    assert_select "form[action=?][method=?]", document_users_path, "post" do

      assert_select "input#document_user_document_id[name=?]", "document_user[document_id]"

      assert_select "input#document_user_user_id[name=?]", "document_user[user_id]"

      assert_select "input#document_user_account_id[name=?]", "document_user[account_id]"

      assert_select "input#document_user_can_edit[name=?]", "document_user[can_edit]"

      assert_select "input#document_user_should_sign[name=?]", "document_user[should_sign]"

      assert_select "input#document_user_email[name=?]", "document_user[email]"

      assert_select "input#document_user_signature[name=?]", "document_user[signature]"

      assert_select "input#document_user_signature_image[name=?]", "document_user[signature_image]"

      assert_select "input#document_user_status[name=?]", "document_user[status]"
    end
  end
end
