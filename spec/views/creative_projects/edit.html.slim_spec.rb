require 'rails_helper'

RSpec.describe "creative_projects/edit", :type => :view do
  before(:each) do
    @creative_project = assign(:creative_project, CreativeProject.create!(
      :title => "MyString",
      :description => "MyText",
      :user => nil,
      :account => nil,
      :public_project => false,
      :lyrics => false,
      :composition => false,
      :recordings => false,
      :performance => false,
      :production => false,
      :financial_services => false,
      :publishing => false,
      :remixing => false,
      :video => false
    ))
  end

  it "renders the edit creative_project form" do
    render

    assert_select "form[action=?][method=?]", creative_project_path(@creative_project), "post" do

      assert_select "input#creative_project_title[name=?]", "creative_project[title]"

      assert_select "textarea#creative_project_description[name=?]", "creative_project[description]"

      assert_select "input#creative_project_user_id[name=?]", "creative_project[user_id]"

      assert_select "input#creative_project_account_id[name=?]", "creative_project[account_id]"

      assert_select "input#creative_project_public_project[name=?]", "creative_project[public_project]"

      assert_select "input#creative_project_lyrics[name=?]", "creative_project[lyrics]"

      assert_select "input#creative_project_composition[name=?]", "creative_project[composition]"

      assert_select "input#creative_project_recordings[name=?]", "creative_project[recordings]"

      assert_select "input#creative_project_performance[name=?]", "creative_project[performance]"

      assert_select "input#creative_project_production[name=?]", "creative_project[production]"

      assert_select "input#creative_project_financial_services[name=?]", "creative_project[financial_services]"

      assert_select "input#creative_project_publishing[name=?]", "creative_project[publishing]"

      assert_select "input#creative_project_remixing[name=?]", "creative_project[remixing]"

      assert_select "input#creative_project_video[name=?]", "creative_project[video]"
    end
  end
end
