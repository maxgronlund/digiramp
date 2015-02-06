require 'rails_helper'

RSpec.describe "cms_texts/show", :type => :view do
  before(:each) do
    @cms_text = assign(:cms_text, CmsText.create!(
      :position => 1,
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
