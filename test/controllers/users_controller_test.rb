require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
    @user.id = 2857842
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
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

    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

  end

  test "should show user" do

    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end


    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    get user_url(@user)
    assert_response :redirect
  end


  test "should update user" do


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


  test "should get user home page" do

    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    get home_user_path(@user) 
    assert_equal "/users/"+@user.id.to_s+"/home", path
  end


  test "search should return results" do

    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    get users_search_path, params: { search: "chicken", mincalories: "", maxcalories: "" }
    assert_equal "/users/search", path
    assert_select "h2", false

  end

  test "search should not return results" do

    #create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

    get users_search_path, params: { search: "thisobviouslydoesntexist", mincalories: "", maxcalories: "" }
    assert_equal "/users/search", path
    assert_select "h2"
  end

end
