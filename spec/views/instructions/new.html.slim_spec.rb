require 'rails_helper'

RSpec.describe "instructions/new", :type => :view do
  before(:each) do
    assign(:instruction, Instruction.new(
      :title => "MyString",
      :body => "MyText",
      :video => "MyString",
      :views => 1,
      :tag => "MyString",
      :position => 1,
      :link => "MyString"
    ))
  end

  it "renders new instruction form" do
    render

    assert_select "form[action=?][method=?]", instructions_path, "post" do

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
