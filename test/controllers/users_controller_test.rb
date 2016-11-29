require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
    @preference = preferences(:one)
    @healthlabel = healthlabels(:one)
    @dietlabel = dietlabels(:one)
  end

  test "should redirect to login" do
    get home_user_path(@user)
    assert_response :redirect
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

  end

  test "should show user" do
    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end


    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    get user_url(@user)
    assert_response :redirect
  end

  # test "should get edit" do
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  test "should update user" do

    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end


    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    patch user_url(@user), params: { user: {email: "test@test.com", password: "test", username: "test" }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    assert_response :redirect
  end

  test "should destroy user" do

    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    assert_difference('User.count', -1) do
      delete deleteuser_user_path(@user)
    end

    assert_redirected_to users_url
  end
end
