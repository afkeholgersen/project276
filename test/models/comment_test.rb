require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "comment should not save if empty comment" do
    c = Comment.new
    assert_not c.save
  end

  test "Comment save in Recipe and User success" do
    c = Comment.new
    c.comment_text = "test"
    c.user_id = 1;
    c.recipe_id = 1;

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

    u.comments.push(c)
    r.comments.push(c)

    assert c.save
    assert Comment.all.length ==3
  end

end
