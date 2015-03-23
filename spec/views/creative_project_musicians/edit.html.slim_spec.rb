require 'rails_helper'

RSpec.describe "creative_project_roles/edit", :type => :view do
  before(:each) do
    @creative_project_role = assign(:creative_project_role, CreativeProjectRole.create!(
      :creative_project => nil,
      :creative_project_user => nil,
      :instrument => "MyString",
      :other_instrument => "MyString"
    ))
  end

  it "renders the edit creative_project_role form" do
    render

    assert_select "form[action=?][method=?]", creative_project_role_path(@creative_project_role), "post" do

      assert_select "input#creative_project_role_creative_project_id[name=?]", "creative_project_role[creative_project_id]"

      assert_select "input#creative_project_role_creative_project_user_id[name=?]", "creative_project_role[creative_project_user_id]"

      assert_select "input#creative_project_role_instrument[name=?]", "creative_project_role[instrument]"

      assert_select "input#creative_project_role_other_instrument[name=?]", "creative_project_role[other_instrument]"
    end
  end
end
