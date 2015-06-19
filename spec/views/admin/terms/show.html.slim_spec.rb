require 'rails_helper'

RSpec.describe "admin/terms/show", type: :view do
  before(:each) do
    @admin_term = assign(:admin_term, Admin::Term.create!(
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
