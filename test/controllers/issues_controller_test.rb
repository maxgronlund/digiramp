require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  setup do
    @issue = issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue" do
    assert_difference('Issue.count') do
      post :create, issue: { account_belongs_to: @issue.account_belongs_to, body: @issue.body, browser: @issue.browser, can_reproducd: @issue.can_reproducd, image: @issue.image, link_to_page: @issue.link_to_page, os: @issue.os, priority: @issue.priority, status: @issue.status, symtom: @issue.symtom, title: @issue.title, user_id: @issue.user_id }
    end

    assert_redirected_to issue_path(assigns(:issue))
  end

  test "should show issue" do
    get :show, id: @issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue
    assert_response :success
  end

  test "should update issue" do
    patch :update, id: @issue, issue: { account_belongs_to: @issue.account_belongs_to, body: @issue.body, browser: @issue.browser, can_reproducd: @issue.can_reproducd, image: @issue.image, link_to_page: @issue.link_to_page, os: @issue.os, priority: @issue.priority, status: @issue.status, symtom: @issue.symtom, title: @issue.title, user_id: @issue.user_id }
    assert_redirected_to issue_path(assigns(:issue))
  end

  test "should destroy issue" do
    assert_difference('Issue.count', -1) do
      delete :destroy, id: @issue
    end

    assert_redirected_to issues_path
  end
end
