require 'rails_helper'

RSpec.describe "raw_images/index", :type => :view do
  before(:each) do
    assign(:raw_images, [
      RawImage.create!(
        :identifier => "Identifier",
        :title => "Title",
        :image => "Image"
      ),
      RawImage.create!(
        :identifier => "Identifier",
        :title => "Title",
        :image => "Image"
      )
    ])
  end

  it "renders a list of raw_images" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
