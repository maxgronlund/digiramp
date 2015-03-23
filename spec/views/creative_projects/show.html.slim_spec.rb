require 'rails_helper'

RSpec.describe "creative_projects/show", :type => :view do
  before(:each) do
    @creative_project = assign(:creative_project, CreativeProject.create!(
      :title => "Title",
      :description => "MyText",
      :user => nil,
      :account => nil,
      :public_project => false,
      :lyrics => false,
      :composition => false,
      :recordings => false,
      :performance => false,
      :production => false,
      :financial_services => false,
      :publishing => false,
      :remixing => false,
      :video => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
