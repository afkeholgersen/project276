require 'test_helper'

class DietlabelTest < ActiveSupport::TestCase

	test "dietlabel table empty" do 
		d = Dietlabel.all
		assert d.length == 2
	end

	test "dietlabel saved" do 
		d = Dietlabel.new
		assert d.save
		assert Dietlabel.all.length > 2
	end	

	test "dietlabel to single preference relation" do
		d = Dietlabel.new
		p = Preference.new

		d.preference.push(p)
		assert d.preference.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 0

		assert d.save
		
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 1

		assert Dietlabel.all.length == 3
		assert Preference.all.length == 3
		

	end

	test "dietlabel to multiple preference relation" do
		d = Dietlabel.new
		p1 = Preference.new
		p2 = Preference.new
		p3 = Preference.new

		d.preference.push(p1)
		d.preference.push(p2)
		d.preference.push(p3)
		assert d.preference.length == 3
		
		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 0	
			
		assert d.save
		
		results = ActiveRecord::Base.connection.select_all("SELECT * from dietlabels_preferences;")
		assert results.length == 3

		assert Dietlabel.all.length == 3
		assert Preference.all.length == 5
		
	end

end
