require 'rails_helper'

RSpec.describe "zip_files/new", :type => :view do
  before(:each) do
    assign(:zip_file, ZipFile.new(
      :title => "MyString",
      :body => "MyText",
      :zip_file => "MyString"
    ))
  end

  it "renders new zip_file form" do
    render

    assert_select "form[action=?][method=?]", zip_files_path, "post" do

      assert_select "input#zip_file_title[name=?]", "zip_file[title]"

      assert_select "textarea#zip_file_body[name=?]", "zip_file[body]"

      assert_select "input#zip_file_zip_file[name=?]", "zip_file[zip_file]"
    end
  end
end
