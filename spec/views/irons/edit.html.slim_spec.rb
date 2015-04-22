require 'rails_helper'

RSpec.describe "irons/edit", :type => :view do
  before(:each) do
    @iron = assign(:iron, Iron.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit iron form" do
    render

    assert_select "form[action=?][method=?]", iron_path(@iron), "post" do

      assert_select "input#iron_title[name=?]", "iron[title]"
    end
  end
end
