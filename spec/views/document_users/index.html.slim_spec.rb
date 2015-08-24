require 'rails_helper'

RSpec.describe "document_users/index", type: :view do
  before(:each) do
    assign(:document_users, [
      DocumentUser.create!(
        :document => nil,
        :user => nil,
        :account => nil,
        :can_edit => false,
        :should_sign => false,
        :email => "Email",
        :signature => "Signature",
        :signature_image => "Signature Image",
        :status => 1
      ),
      DocumentUser.create!(
        :document => nil,
        :user => nil,
        :account => nil,
        :can_edit => false,
        :should_sign => false,
        :email => "Email",
        :signature => "Signature",
        :signature_image => "Signature Image",
        :status => 1
      )
    ])
  end

  it "renders a list of document_users" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Signature".to_s, :count => 2
    assert_select "tr>td", :text => "Signature Image".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
