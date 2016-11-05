require 'test_helper'

class HealthlabelTest < ActiveSupport::TestCase

	test "healthlabel table empty" do 
		h = Healthlabel.all
		assert h.length == 2
	end

	test "healthlabel saved" do 
		h = Healthlabel.new
		assert h.save
		assert Healthlabel.all.length > 2
	end	

	test "healthlabel to single preference relation" do
		h = Healthlabel.new
		p = Preference.new

		h.preference.push(p)
		assert h.preference.length == 1

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 0

		assert h.save

		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 1

		assert Healthlabel.all.length == 3
		assert Preference.all.length == 3
		

	end

	test "healthlabel to multiple preference relation" do
		h = Healthlabel.new
		p1 = Preference.new
		p2 = Preference.new
		p3 = Preference.new

		h.preference.push(p1)
		h.preference.push(p2)
		h.preference.push(p3)
		assert h.preference.length == 3

		#get results from the relation table in the db. no model because the table doesn't need one so we need to check if data being stored here through the relation
		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 0

		assert h.save

		results = ActiveRecord::Base.connection.select_all("SELECT * from healthlabels_preferences;")
		assert results.length == 3

		assert Healthlabel.all.length == 3
		assert Preference.all.length == 5
		

	end

end
