require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "comment should not save if empty comment" do
    c1 = Comment.new
    assert_not c1.save
  end

  test "Comment save in Recipe and User success" do
    c1 = Comment.new
    c1.comment_text = "test"

    # make a new user instance for c to save to
    u = User.new
  	p = Preference.new
  	s = Savedrecipe.new

  	u.preference = p
  	u.savedrecipe = s


    u.username="test"
    u.password="test"
    u.email="test@gmail.com"

  	assert u.save

    # make a new recipe instance for c to save to
    r = Recipe.new
		assert r.save

    u.comments.push(c1)
    r.comments.push(c1)

    c1.user = u
    c1.recipe = r

    assert c1.save
    assert Comment.all.length == 3
    # Check default vote value == 0 if user does not vote
    assert c1.vote == 0

    c2 = Comment.new
    c2.comment_text = "test2"
    c2.vote = 1

    u.comments.push(c2)
    r.comments.push(c2)

    c2.user = u
    c2.recipe = r

    assert c2.save
    assert Comment.all.length == 4
    # Check if user votes, value is saved
    assert c2.vote == 1
  end

  test "comment has a user_id but no recipe_id fail to save" do
    c = Comment.new
    c.comment_text = "test"

    # make a new user instance for c to save to
    u = User.new
    p = Preference.new
    s = Savedrecipe.new

    u.preference = p
    u.savedrecipe = s


    u.username="test"
    u.password="test"
    u.email="test@gmail.com"

    assert u.save

    # make a new recipe instance for c to save to

    u.comments.push(c)

    c.user = u

    assert_not c.save
  end

  test "comment has a recipe_id but no user_id fail to save" do
    c = Comment.new
    c.comment_text = "test"

    # make a new recipe instance for c to save to
    r = Recipe.new
    assert r.save

    r.comments.push(c)

    c.recipe = r

    assert_not c.save
  end
end
