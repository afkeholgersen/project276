require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
    @preference = preferences(:one)
    @healthlabel = healthlabels(:one)
    @dietlabel = dietlabels(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      @user.email="test@test.com"
      @user.password="test"
      @user.username="test"
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do

    patch user_url(@user), params: { user: {email: "test2@test.com", password: "test2", username: "test2" }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    assert_redirected_to @user
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
