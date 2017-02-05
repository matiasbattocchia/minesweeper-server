require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get games_new_url
    assert_response :success
  end

  test "should get recover" do
    get games_recover_url
    assert_response :success
  end

  test "should get reveal" do
    get games_reveal_url
    assert_response :success
  end

  test "should get flag" do
    get games_flag_url
    assert_response :success
  end

  test "should get unflag" do
    get games_unflag_url
    assert_response :success
  end

end
