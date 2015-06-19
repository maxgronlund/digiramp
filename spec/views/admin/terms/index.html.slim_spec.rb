require 'rails_helper'

RSpec.describe "admin/terms/index", type: :view do
  before(:each) do
    assign(:admin_terms, [
      Admin::Term.create!(
        :title => "Title",
        :body => "MyText"
      ),
      Admin::Term.create!(
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of admin/terms" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
