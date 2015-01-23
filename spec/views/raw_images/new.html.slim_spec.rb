require 'rails_helper'

RSpec.describe "raw_images/new", :type => :view do
  before(:each) do
    assign(:raw_image, RawImage.new(
      :identifier => "MyString",
      :title => "MyString",
      :image => "MyString"
    ))
  end

  it "renders new raw_image form" do
    render

    assert_select "form[action=?][method=?]", raw_images_path, "post" do

      assert_select "input#raw_image_identifier[name=?]", "raw_image[identifier]"

      assert_select "input#raw_image_title[name=?]", "raw_image[title]"

      assert_select "input#raw_image_image[name=?]", "raw_image[image]"
    end
  end
end
