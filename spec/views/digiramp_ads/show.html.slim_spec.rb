require 'rails_helper'

RSpec.describe "digiramp_ads/show", :type => :view do
  before(:each) do
    @digiramp_ad = assign(:digiramp_ad, DigirampAd.create!(
      :identifyer => "Identifyer",
      :title => "Title",
      :body => "MyText",
      :image => "Image",
      :snippet => "Snippet",
      :link => "Link",
      :button_link => "Button Link",
      :button_style => "Button Style",
      :css_snipet => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifyer/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Snippet/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Button Link/)
    expect(rendered).to match(/Button Style/)
    expect(rendered).to match(/MyText/)
  end
end
