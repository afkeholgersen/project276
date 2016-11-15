require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user table empty" do
  	u = User.all
  	assert u.length == 2
  end

  test "user fail save, no preference or savedrecipe" do
  	u = User.new
  	assert_not u.save
  end

  test "user fail save, no preference" do
  	u = User.new
  	s = Savedrecipe.new
  	u.savedrecipe = s
  	assert_not u.save
  end

  test "user fail save, no savedrecipe" do
  	u = User.new
  	p = Preference.new
  	u.preference = p
  	assert_not u.save
  end

  test "user save success" do

  	u = User.new
  	p = Preference.new
  	s = Savedrecipe.new

  	u.preference = p
  	u.savedrecipe = s


    u.username="test"
    u.password="test"
    u.email="test@gmail.com"

  	assert u.save

  	assert User.all.length == 3;
  	assert Preference.all.length == 3;
  	assert Savedrecipe.all.length == 3;
  end

  test "user email validation" do
    u=User.new
    p=Preference.new
    s=Savedrecipe.new
    u.preference = p
    u.savedrecipe = s
    u.username="test"
    u.password="password"
    #the email should be the only reason this test does not pass
    u.email="test"
    assert_not u.save
  end

end
