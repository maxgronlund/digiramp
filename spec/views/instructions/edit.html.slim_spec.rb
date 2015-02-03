require 'rails_helper'

RSpec.describe "instructions/edit", :type => :view do
  before(:each) do
    @instruction = assign(:instruction, Instruction.create!(
      :title => "MyString",
      :body => "MyText",
      :video => "MyString",
      :views => 1,
      :tag => "MyString",
      :position => 1,
      :link => "MyString"
    ))
  end

  it "renders the edit instruction form" do
    render

    assert_select "form[action=?][method=?]", instruction_path(@instruction), "post" do

      assert_select "input#instruction_title[name=?]", "instruction[title]"

      assert_select "textarea#instruction_body[name=?]", "instruction[body]"

      assert_select "input#instruction_video[name=?]", "instruction[video]"

      assert_select "input#instruction_views[name=?]", "instruction[views]"

      assert_select "input#instruction_tag[name=?]", "instruction[tag]"

      assert_select "input#instruction_position[name=?]", "instruction[position]"

      assert_select "input#instruction_link[name=?]", "instruction[link]"
    end
  end
end
