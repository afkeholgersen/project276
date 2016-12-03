require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users
  # test "the truth" do
  #   assert true
  # end

  def test_login

    # get the login page
    get "/sessions/new"
    assert_equal 200, status

    # create the user info
    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"
    
    # post the user info to create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    #login with the user that was just created and assert that it redirects us
    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect

  end


  def test_recipe

    # get the login page
    get "/sessions/new"
    assert_equal 200, status

    # create the user info
    @user = users(:one)
    @user.email="test@test.com"
    @user.password="test"
    @user.username="test"

    # post the user info to create the user first
    assert_difference('User.count') do
      post users_url, params: { user: {email: @user.email, password: @user.password, username: @user.username }, preference: { healthlabel_id: @healthlabel, dietlabel_id: @dietlabel } }
    end

    #login with the user that was just created and assert that it redirects us
    post "/sessions", params: { username: "test", password: "test"}
    assert_response :redirect


    #create the recipe with a real example and store in the database
    Recipe.create(:id => 1, 
      :source => "http://www.edamam.com/ontologies/edamam.owl#recipe_b6f951bb6d8720017c403559435955f9", 
      :sourceIcon => "https://www.edamam.com/web-img/512/512c9f709292132327ae4db6de7caf17.jpg", 
      :title => "Spicy and Salty Mango Lassi", 
      :dietLabels => '[ "Balanced", "Low-Sodium" ]', 
      :healthLabels => '[ "Vegetarian", "Gluten-Free", "Egg-Free", "Peanut-Free", "Tree-Nut-Free", "Soy-Free", "Fish-Free", "Shellfish-Free" ]'
      )

    #get the recipe page that we just created
    get "/recipes/1", params: {id: 1 }

    #assert that the page loaded successfully (makes the API call and parses + displays the json)
    assert_equal 200, status
    assert_equal "/recipes/1", path
    
  end



end
