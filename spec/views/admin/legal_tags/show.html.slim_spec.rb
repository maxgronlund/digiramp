require 'rails_helper'

RSpec.describe "admin/legal_tags/show", type: :view do
  before(:each) do
    @admin_legal_tag = assign(:admin_legal_tag, Admin::LegalTag.create!(
      :title => "Title",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Body/)
  end
end
