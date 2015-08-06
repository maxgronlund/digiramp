require 'rails_helper'

RSpec.describe "blacklist_domains/index", type: :view do
  before(:each) do
    assign(:blacklist_domains, [
      BlacklistDomain.create!(
        :domain => "Domain"
      ),
      BlacklistDomain.create!(
        :domain => "Domain"
      )
    ])
  end

  it "renders a list of blacklist_domains" do
    render
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
  end
end
