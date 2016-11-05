require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

	test "create successful session" do

		#create the user first
    assert_difference('User.count') do
    	@user = users(:one)
      @user.email="test@test.com"
      @user.password="test"
      @user.username="test"
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    #login with the user
		post "/sessions", params: { username: "test", password: "test"}
		assert_redirected_to users_url
	end


	test "unsucessful session" do
		#login with a user that doesn't exist
		post "/sessions", params: { username: "test", password: "test"}
		assert_response :success

	end

end