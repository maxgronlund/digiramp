require 'rails_helper'

RSpec.describe "helps/show", :type => :view do
  before(:each) do
    @help = assign(:help, Help.create!(
      :identifier => "Identifier",
      :button => "Button",
      :title => "Title",
      :body => "MyText",
      :snippet => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Button/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
