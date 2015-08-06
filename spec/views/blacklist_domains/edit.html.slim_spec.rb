require 'rails_helper'

RSpec.describe "blacklist_domains/edit", type: :view do
  before(:each) do
    @blacklist_domain = assign(:blacklist_domain, BlacklistDomain.create!(
      :domain => "MyString"
    ))
  end

  it "renders the edit blacklist_domain form" do
    render

    assert_select "form[action=?][method=?]", blacklist_domain_path(@blacklist_domain), "post" do

      assert_select "input#blacklist_domain_domain[name=?]", "blacklist_domain[domain]"
    end
  end
end
