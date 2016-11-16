require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "comment saves to user" do
    u = User.new
    p = Preference.new
    s = Savedrecipe.new

    u.preference = p
    u.savedrecipe = s

    u.username="test"
    u.password="test"
    u.email="test@gmail.com"

    u.save #create a successful user
    assert u.comments.length==0

    c1 = Comment.new
    c2 = Comment.new

    u.comments.push(c1)
    u.comments.push(c2)

    #see that there are now two comments to this user
    assert u.comments.length==2
    c1.save
    c2.save

    results = ActiveRecord::Base.connection.select_all("SELECT from comments, users WHERE comments.user_id= u.user_id ;")
    assert results.length == 2

  end

  test "comment saves to recipe" do
      r = Recipe.new
      r.save
      c1 = Comment.new
      c2 = Comment.new
      #results = ActiveRecord::Base.connection.select_all("SELECT Comment from recipes;")
    #  assert results.length == 0

      assert r.comments.length == 0

      r.comments.push(c1)
      r.comments.push(c2)

      assert r.comments.length == 2

      c1.save
    #  results = ActiveRecord::Base.connection.select_all("SELECT * from recipes;")
    #  assert results.comments.length == 1

      c2.save
    #  results = ActiveRecord::Base.connection.select_all("SELECT * from recipes;")
    #  assert results.comments.length == 2
  end

end
