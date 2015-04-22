require 'rails_helper'

RSpec.describe "irons/new", :type => :view do
  before(:each) do
    assign(:iron, Iron.new(
      :title => "MyString"
    ))
  end

  it "renders new iron form" do
    render

    assert_select "form[action=?][method=?]", irons_path, "post" do

      assert_select "input#iron_title[name=?]", "iron[title]"
    end
  end
end
