require 'test_helper'

class PreferenceTest < ActiveSupport::TestCase

	#weird bug where database gets initialzed with 2 preferences in the beginning so I set this to 2.
	test "preference table empty" do 
		p = Preference.all
		assert p.length == 2
	end

	test "preference saved" do 
		p = Preference.new
		assert p.save
		assert Preference.all.length > 2
	end	

	test "preference to single dietlabel relation" do
		p = Preference.new
		d = Dietlabel.new

		p.dietlabel.push(d)
		assert p.dietlabel.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 0

		#save the whole relation
		assert p.save
		
		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 1
		
		assert Preference.all.length == 3
		assert Dietlabel.all.length == 3
		

	end

	test "preference to multiple dietlabel relation" do
		p = Preference.new
		d1 = Dietlabel.new
		d2 = Dietlabel.new
		d3 = Dietlabel.new

		p.dietlabel.push(d1)
		p.dietlabel.push(d2)
		p.dietlabel.push(d3)
		assert p.dietlabel.length == 3

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 0

		#save the whole relation
		assert p.save

		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 3

		assert Preference.all.length == 3
		assert Dietlabel.all.length == 5
			
	end


	test "preference to single healthlabel relation" do
		p = Preference.new
		h = Healthlabel.new

		p.healthlabel.push(h)
		assert p.healthlabel.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 0

		#save the whole relation
		assert p.save

		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 1

		assert Preference.all.length == 3
		assert Healthlabel.all.length == 3
		

	end

	test "preference to multiple healthlabel relation" do
		p = Preference.new
		h1 = Healthlabel.new
		h2 = Healthlabel.new
		h3 = Healthlabel.new

		p.healthlabel.push(h1)
		p.healthlabel.push(h2)
		p.healthlabel.push(h3)
		assert p.healthlabel.length == 3

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 0

		#save the whole relation
		assert p.save

		#data should now be populated after saving the preference from the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 3

		assert Preference.all.length == 3
		assert Healthlabel.all.length == 5

	end


end
