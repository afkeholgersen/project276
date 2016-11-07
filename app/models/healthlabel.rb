class Healthlabel < ApplicationRecord
	has_and_belongs_to_many :preference
end
