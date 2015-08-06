require 'rails_helper'

RSpec.describe "blacklist_domains/new", type: :view do
  before(:each) do
    assign(:blacklist_domain, BlacklistDomain.new(
      :domain => "MyString"
    ))
  end

  it "renders new blacklist_domain form" do
    render

    assert_select "form[action=?][method=?]", blacklist_domains_path, "post" do

      assert_select "input#blacklist_domain_domain[name=?]", "blacklist_domain[domain]"
    end
  end
end
