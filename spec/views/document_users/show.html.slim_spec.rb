require 'rails_helper'

RSpec.describe "document_users/show", type: :view do
  before(:each) do
    @document_user = assign(:document_user, DocumentUser.create!(
      :document => nil,
      :user => nil,
      :account => nil,
      :can_edit => false,
      :should_sign => false,
      :email => "Email",
      :signature => "Signature",
      :signature_image => "Signature Image",
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Signature/)
    expect(rendered).to match(/Signature Image/)
    expect(rendered).to match(/1/)
  end
end
