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

    # post the login and follow through to the sessions page
    # which later takes us to the home page
    post "/sessions", params: { username: users(:one).username, password: users(:one).password }

    assert_equal 200, status
    assert_equal "/sessions", path
  end


  def test_recipe
    #create the recipe
    Recipe.create(:id => 1, :source => "teast", :sourceIcon => "asdsa", :title => "asdhiqw", :dietLabels => "asd", :healthLabels => "SOMETHING")

    #get the recipe page
    get "/recipes/1", params: {id: 1 }

    #assert that the page loaded successfully!
    assert_equal 200, status
    assert_equal "/recipes/1", path
  end



end
