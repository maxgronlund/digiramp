require 'rails_helper'

RSpec.describe "zip_files/show", :type => :view do
  before(:each) do
    @zip_file = assign(:zip_file, ZipFile.create!(
      :title => "Title",
      :body => "MyText",
      :zip_file => "Zip File"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Zip File/)
  end
end
