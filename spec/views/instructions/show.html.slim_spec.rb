require 'rails_helper'

RSpec.describe "instructions/show", :type => :view do
  before(:each) do
    @instruction = assign(:instruction, Instruction.create!(
      :title => "Title",
      :body => "MyText",
      :video => "Video",
      :views => 1,
      :tag => "Tag",
      :position => 2,
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Video/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Tag/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Link/)
  end
end
