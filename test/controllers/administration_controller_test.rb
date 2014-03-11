require 'test_helper'

class AdministrationControllerTest < ActionController::TestCase
  test "should get edit_match_result" do
    get :edit_match_result
    assert_response :success
  end

  test "should get update_result" do
    get :update_result
    assert_response :success
  end

  test "should get update_standings" do
    get :update_standings
    assert_response :success
  end

  test "should get edit_ranking" do
    get :edit_ranking
    assert_response :success
  end

  test "should get update_ranking" do
    get :update_ranking
    assert_response :success
  end

end
