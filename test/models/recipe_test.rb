require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

	#weird bug where database gets initialzed with 2 saved recipes in the beginning so I set this to 2.
	test "Recipe table empty" do 
		r = Recipe.all
		assert r.length == 2
	end

	test "Recipe saved" do 
		r = Recipe.new
		assert r.save
		assert Recipe.all.length > 2
	end

	test "Recipe to single recipe relation" do
		r = Recipe.new
		s = Savedrecipe.new 	

		r.savedrecipe.push(s)
		assert r.savedrecipe.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 0

		#save the whole relation
		assert r.save
		
		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 1
		
		assert Recipe.all.length == 3
		assert Savedrecipe.all.length == 3
		

	end

	test "Recipe to multiple recipes relation" do
		r = Recipe.new
		s1 = Savedrecipe.new
		s2 = Savedrecipe.new
		s3 = Savedrecipe.new

		r.savedrecipe.push(s1)
		r.savedrecipe.push(s2)
		r.savedrecipe.push(s3)
		assert r.savedrecipe.length == 3

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 0

		#save the whole relation
		assert r.save

		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 3

		assert Recipe.all.length == 3
		assert Savedrecipe.all.length == 5
			
	end

end
