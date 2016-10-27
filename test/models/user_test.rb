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

  test "user save" do

  	u = User.new
  	p = Preference.new
  	s = Savedrecipe.new

  	u.preference = p
  	u.savedrecipe = s

  	assert u.save

  	assert User.all.length == 3;
  	assert Preference.all.length == 3;
  	assert Savedrecipe.all.length == 3;
  end

end
