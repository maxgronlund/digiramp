require 'rails_helper'

RSpec.describe "blacklist_domains/show", type: :view do
  before(:each) do
    @blacklist_domain = assign(:blacklist_domain, BlacklistDomain.create!(
      :domain => "Domain"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Domain/)
  end
end
