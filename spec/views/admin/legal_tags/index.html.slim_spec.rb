require 'rails_helper'

RSpec.describe "admin/legal_tags/index", type: :view do
  before(:each) do
    assign(:admin_legal_tags, [
      Admin::LegalTag.create!(
        :title => "Title",
        :body => "Body"
      ),
      Admin::LegalTag.create!(
        :title => "Title",
        :body => "Body"
      )
    ])
  end

  it "renders a list of admin/legal_tags" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
