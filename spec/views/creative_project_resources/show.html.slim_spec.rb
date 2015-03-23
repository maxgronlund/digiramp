require 'rails_helper'

RSpec.describe "creative_project_resources/show", :type => :view do
  before(:each) do
    @creative_project_resource = assign(:creative_project_resource, CreativeProjectResource.create!(
      :creative_project => nil,
      :user => nil,
      :title => "Title",
      :description => "MyText",
      :file => "File",
      :file_size => "File Size",
      :content_type => "Content Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/File/)
    expect(rendered).to match(/File Size/)
    expect(rendered).to match(/Content Type/)
  end
end
