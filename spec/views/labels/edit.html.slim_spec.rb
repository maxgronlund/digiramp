require 'rails_helper'

RSpec.describe "labels/edit", type: :view do
  before(:each) do
    @label = assign(:label, Label.create!(
      :title => "MyString",
      :body => "MyText",
      :image => "MyString",
      :user => nil,
      :account => nil
    ))
  end

  it "renders the edit label form" do
    render

    assert_select "form[action=?][method=?]", label_path(@label), "post" do

      assert_select "input#label_title[name=?]", "label[title]"

      assert_select "textarea#label_body[name=?]", "label[body]"

      assert_select "input#label_image[name=?]", "label[image]"

      assert_select "input#label_user_id[name=?]", "label[user_id]"

      assert_select "input#label_account_id[name=?]", "label[account_id]"
    end
  end
end
