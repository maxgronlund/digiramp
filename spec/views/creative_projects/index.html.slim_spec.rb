require 'rails_helper'

RSpec.describe "creative_projects/index", :type => :view do
  before(:each) do
    assign(:creative_projects, [
      CreativeProject.create!(
        :title => "Title",
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
      ),
      CreativeProject.create!(
        :title => "Title",
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
      )
    ])
  end

  it "renders a list of creative_projects" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
