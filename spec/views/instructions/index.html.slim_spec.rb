require 'rails_helper'

RSpec.describe "instructions/index", :type => :view do
  before(:each) do
    assign(:instructions, [
      Instruction.create!(
        :title => "Title",
        :body => "MyText",
        :video => "Video",
        :views => 1,
        :tag => "Tag",
        :position => 2,
        :link => "Link"
      ),
      Instruction.create!(
        :title => "Title",
        :body => "MyText",
        :video => "Video",
        :views => 1,
        :tag => "Tag",
        :position => 2,
        :link => "Link"
      )
    ])
  end

  it "renders a list of instructions" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Video".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
