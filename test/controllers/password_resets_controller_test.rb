require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  
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


  test "should get new" do
    get password_resets_new_url
    assert_response :success
  end


  test "should create password url token" do
  	post password_resets_path, params: { email: "test@test.com" }
    result = ActiveRecord::Base.connection.select_all("SELECT password_reset_sent_at FROM users;")
    assert result.length > 0
    assert_response :redirect

  end



end
