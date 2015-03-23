require 'rails_helper'

RSpec.describe "creative_project_users/edit", :type => :view do
  before(:each) do
    @creative_project_user = assign(:creative_project_user, CreativeProjectUser.create!(
      :creative_project => nil,
      :user => nil,
      :approved_by_project_manager => false,
      :approved_by_user => false,
      :locked => false,
      :email => "MyString",
      :created_by => 1,
      :writers => false,
      :composers => false,
      :musicians => false,
      :dancers => false,
      :live_performers => false,
      :producers => false,
      :studio_facilities => false,
      :financial_services => false,
      :legal_services => false,
      :publishers => false,
      :remixers => false,
      :audio_engineers => false,
      :video_artists => false,
      :graphic_artists => false,
      :other => false
    ))
  end

  it "renders the edit creative_project_user form" do
    render

    assert_select "form[action=?][method=?]", creative_project_user_path(@creative_project_user), "post" do

      assert_select "input#creative_project_user_creative_project_id[name=?]", "creative_project_user[creative_project_id]"

      assert_select "input#creative_project_user_user_id[name=?]", "creative_project_user[user_id]"

      assert_select "input#creative_project_user_approved_by_project_manager[name=?]", "creative_project_user[approved_by_project_manager]"

      assert_select "input#creative_project_user_approved_by_user[name=?]", "creative_project_user[approved_by_user]"

      assert_select "input#creative_project_user_locked[name=?]", "creative_project_user[locked]"

      assert_select "input#creative_project_user_email[name=?]", "creative_project_user[email]"

      assert_select "input#creative_project_user_created_by[name=?]", "creative_project_user[created_by]"

      assert_select "input#creative_project_user_writers[name=?]", "creative_project_user[writers]"

      assert_select "input#creative_project_user_composers[name=?]", "creative_project_user[composers]"

      assert_select "input#creative_project_user_musicians[name=?]", "creative_project_user[musicians]"

      assert_select "input#creative_project_user_dancers[name=?]", "creative_project_user[dancers]"

      assert_select "input#creative_project_user_live_performers[name=?]", "creative_project_user[live_performers]"

      assert_select "input#creative_project_user_producers[name=?]", "creative_project_user[producers]"

      assert_select "input#creative_project_user_studio_facilities[name=?]", "creative_project_user[studio_facilities]"

      assert_select "input#creative_project_user_financial_services[name=?]", "creative_project_user[financial_services]"

      assert_select "input#creative_project_user_legal_services[name=?]", "creative_project_user[legal_services]"

      assert_select "input#creative_project_user_publichers[name=?]", "creative_project_user[publichers]"

      assert_select "input#creative_project_user_remixers[name=?]", "creative_project_user[remixers]"

      assert_select "input#creative_project_user_audio_engineers[name=?]", "creative_project_user[audio_engineers]"

      assert_select "input#creative_project_user_video_artists[name=?]", "creative_project_user[video_artists]"

      assert_select "input#creative_project_user_graphic_artists[name=?]", "creative_project_user[graphic_artists]"

      assert_select "input#creative_project_user_other[name=?]", "creative_project_user[other]"
    end
  end
end
