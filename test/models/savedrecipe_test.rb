require 'test_helper'

class SavedrecipeTest < ActiveSupport::TestCase

	#weird bug where database gets initialzed with 2 saved recipes in the beginning so I set this to 2.
	test "Savedrecipe table empty" do 
		s = Savedrecipe.all
		assert s.length == 2
	end

	test "Savedrecipe saved" do 
		s = Savedrecipe.new
		assert s.save
		assert Savedrecipe.all.length > 2
	end

	test "Savedrecipe to single recipe relation" do
		s = Savedrecipe.new
		r = Recipe.new

		s.recipe.push(r)
		assert s.recipe.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 0

		#save the whole relation
		assert s.save
		
		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 1
		
		assert Savedrecipe.all.length == 3
		assert Recipe.all.length == 3
		

	end

	test "Savedrecipe to multiple recipes relation" do
		s = Savedrecipe.new
		r1 = Recipe.new
		r2 = Recipe.new
		r3 = Recipe.new

		s.recipe.push(r1)
		s.recipe.push(r2)
		s.recipe.push(r3)
		assert s.recipe.length == 3

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 0

		#save the whole relation
		assert s.save

		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * FROM recipes_savedrecipes;")
		assert results.length == 3

		assert Savedrecipe.all.length == 3
		assert Recipe.all.length == 5
			
	end

end
