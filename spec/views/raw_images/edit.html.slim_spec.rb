require 'rails_helper'

RSpec.describe "raw_images/edit", :type => :view do
  before(:each) do
    @raw_image = assign(:raw_image, RawImage.create!(
      :identifier => "MyString",
      :title => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit raw_image form" do
    render

    assert_select "form[action=?][method=?]", raw_image_path(@raw_image), "post" do

      assert_select "input#raw_image_identifier[name=?]", "raw_image[identifier]"

      assert_select "input#raw_image_title[name=?]", "raw_image[title]"

      assert_select "input#raw_image_image[name=?]", "raw_image[image]"
    end
  end
end
